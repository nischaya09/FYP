from rest_framework import serializers
from .models import GymProduct, ProductBuyerInfo

class ProductSerializer(serializers.ModelSerializer):
    class Meta:
        model = GymProduct
        fields = ["id", "name", "image"]

class ProductDetailSerializer(serializers.ModelSerializer):
    class Meta:
        model = GymProduct
        fields = ["id", "name", "image", "price", "subtitle", "description"]

class ProductBuyerSerializer(serializers.ModelSerializer):
    class Meta:
        model = ProductBuyerInfo
        fields = ["id", "user", "product", "date"]