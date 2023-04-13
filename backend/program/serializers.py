from rest_framework import serializers
from .models import Program, SubProgram, Description

class ProgramSerializer(serializers.ModelSerializer):
    class Meta:
        model =  Program
        fields = ["id", "name", "image"]

class SubProgramSerializer(serializers.ModelSerializer):
    class Meta:
        model =  SubProgram
        fields = ["id", "program", "name", "image"]

class DescriptionSerializer(serializers.ModelSerializer):
    class Meta:
        model =  Description
        fields = ["id", "sub_program", "title", "desc", "image"]