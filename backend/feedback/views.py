from rest_framework import viewsets, status
from .serializers import FeedbackSerializer
from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework.permissions import IsAuthenticated

# Create your views here.


class AddFeedback(APIView):

    permission_classes = [IsAuthenticated]

    def post(self, request):
        user = request.user
        newdata = request.data
        newdata["user"] = user.id
        serializer = FeedbackSerializer(data=newdata)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        else:
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

