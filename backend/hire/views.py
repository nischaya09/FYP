from .models import Coach, HireInfo
from rest_framework import  status
from .serializers import CoachSerializer, HireInfoSerializer
from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework.permissions import IsAuthenticated

# Create your views here.

class GetCoach(APIView):

    permission_classes = [IsAuthenticated]

    def get(self, request):
        serializer = CoachSerializer(Coach.objects.all(), many=True, context= {'request': request})
        return Response(serializer.data, status=status.HTTP_200_OK)


class HireCoach(APIView):

    permission_classes = [IsAuthenticated]

    def post(self, request, id):
     coach_id = id
     user = request.user
     newdata = {
         "user" : user.id,
        "coach" : coach_id
     }
     serializer = HireInfoSerializer(data= newdata)
     if serializer.is_valid():
         serializer.save()
         return Response(serializer.data, status=status.HTTP_201_CREATED)
     else:
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)