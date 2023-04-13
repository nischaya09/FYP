from .models import Notification
from rest_framework import  status
from .serializers import NotificationSerializer
from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework.permissions import IsAuthenticated

# Create your views here.
class GetNotifications(APIView):

    permission_classes = [IsAuthenticated]

    def get(self, request):
        serializer = NotificationSerializer(Notification.objects.all().order_by('-id'), many=True)
        return Response(serializer.data, status=status.HTTP_200_OK)
    
    
class NumberofNotifications(APIView):
        
    def get(self,request): 
         count_objects = Notification.objects.all().count()
         return Response({"number": count_objects}, status=status.HTTP_200_OK)