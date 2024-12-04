# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models

class Student(models.Model):
    name = models.CharField(max_length=100)
    email = models.EmailField()

class Course(models.Model):
    title = models.CharField(max_length=100)
    students = models.ManyToManyField(Student)
