from django.contrib import admin
from .models import Program, SubProgram, Description

# Register your models here.
admin.site.register(Program)
admin.site.register(SubProgram)
admin.site.register(Description)