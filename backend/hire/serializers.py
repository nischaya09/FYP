from rest_framework import serializers
from .models import Coach, HireInfo

class CoachSerializer(serializers.ModelSerializer):
    class Meta:
        model = Coach
        fields = ["id", "name", "email", "phone", "image"]

class HireInfoSerializer(serializers.ModelSerializer):
    class Meta:
        model = HireInfo
        fields = ["id", "user", "coach", "date"]
