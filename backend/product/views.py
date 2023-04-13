from .models import GymProduct
from rest_framework import viewsets, status
from .serializers import ProductSerializer, ProductDetailSerializer, ProductBuyerSerializer
from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework.permissions import IsAuthenticated


class GetProducts(APIView):

    def get(self, request):
        serializer = ProductSerializer(GymProduct.objects.all(), many=True, context= {'request': request})
        return Response(serializer.data, status=status.HTTP_200_OK)


class GetProductDetail(APIView):

    def get(self,request,pk):
        serializer = ProductDetailSerializer(GymProduct.objects.get(id=pk), many=False, context= {'request': request} )
        return Response(serializer.data, status=status.HTTP_200_OK)

class ProductBuyer(APIView):

    permission_classes = [IsAuthenticated]

    def post(self, request, id):
        newdata = request.data
        user = request.user
        newdata["user"] = user.id
        newdata["product"] = id
        serializer = ProductBuyerSerializer(data=newdata)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        else:
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
            