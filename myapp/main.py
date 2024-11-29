import os
from fastapi import FastAPI, Depends
from pydantic import BaseModel
from sqlalchemy import create_engine, Column, Integer, String, ForeignKey
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker, Session, relationship

# Fetch database_url from the environment variable
DATABASE_URL = os.getenv("DATABASE_URL", "sqlite:///./school.db")

# Setup SQLAlchemy engine, session and declarative base
engine = create_engine(DATABASE_URL, connect_args={"check_same_thread": False})
sessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)
Base = declarative_base()

# Create FastAPI app
app =FastAPI()

# Database Models
class Student(Base):
    __tablename__ = "students"
    id = Column(Integer, primary_key=True, index=True)
    name = Column(String, index=True)
    email = Column(String, unique=True, index=True)

class Course(Base):
    __tablename__ = "courses"
    id = Column(Integer, primary_key=True, index=True)
    name = Column(String, index=True)
    description = Column(String)

class Enrollment(Base):
    __tablename__ = "enrollments"
    id = Column(Integer, primary_key=True, index=True)
    student_id = Column(Integer, ForeignKey("students.id"), index=True)
    course_id = Column(Integer, ForeignKey("courses.id"), index=True)

    # Relationships
    student = relationship("Student", back_populates="enrollments")
    course = relationship("Course", back_populates="enrollments")

# Establish back-population relationships
Student.enrollments = relationship("Enrollment", back_populates="student", cascade="all, delete-orphan")
Course.enrollments = relationship("Enrollment", back_populates="course", cascade="all, delete-orphan")

# Create tables
Base.metadata.create_all(bind=engine)

# Pydantic Models
class StudentBase(BaseModel):
    name: str
    email: str

class StudentCreate(StudentBase):
    pass

class StudentResponse(StudentBase):
    id: int

    class Config:
        orm_mode = True

class CourseBase(BaseModel):
    name: str
    description: str

class CourseCreate(CourseBase):
    pass

class CourseResponse(CourseBase):
    id: int

    class Config:
        orm_mode= True

class EnrollmentBase(BaseModel):
    student_id: int
    course_id: int

class EnrollmentResponse(EnrollmentBase):
    id: int

    class Config:
        orm_mode=True

class EnrollmentCreate(EnrollmentBase):
    pass

# Dependency to get database session
def get_db():
    db = sessionLocal()
    try:
        yield db
    finally:
        db.close()

# FastAPI Endpoints
@app.post("/students/", response_model=StudentResponse)
def create_student(student: StudentCreate, db:Session = Depends(get_db)):
    new_student = Student(**student.dict())
    db.add(new_student)
    db.commit()
    db.refresh(new_student)
    return new_student

@app.post("/courses/", response_model=CourseResponse)
def create_course(course: CourseCreate, db: Session = Depends(get_db)):
    new_course = Course(**course.dict())
    db.add(new_course)
    db.commit()
    db.refresh(new_course)
    return new_course

@app.post("/enrollments/", response_model=EnrollmentResponse)
def enroll_student(enrollment: EnrollmentCreate, db: Session=Depends(get_db)):
    new_enrollment = Enrollment(**enrollment.dict())
    db.add(new_enrollment)
    db.commit()
    db.refresh(new_enrollment)
    return new_enrollment

@app.get("/students/", response_model=list[StudentResponse])
def get_students(db: Session = Depends(get_db)):
    return db.query(Student).all()

@app.get("/courses/", response_model=list[CourseResponse])
def get_courses(db: Session = Depends(get_db)):
    return db.query(Course).all()

@app.get("/enrollments/", response_model=list[EnrollmentResponse])
def get_enrollments(db: Session = Depends(get_db)):
    return db.query(Course).all()

@app.get("dashboard_summary/")
def get_dash_summary(db: Session = Depends(get_db)):
    total_students = db.query(Student).count()
    total_courses = db.query(Course).count()
    total_enrollments = db.query(Enrollment).count()

    return {
        "total_students": total_students,
        "total_courses": total_courses,
        "total_enrollments": total_enrollments
    }