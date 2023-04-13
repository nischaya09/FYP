from django.conf import settings
from .models import Profile, otp
from rest_framework import viewsets, status
from .serializers import ProfileSerializer, GetProfileSerializer
from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework.permissions import IsAuthenticated
import random as r
from django.core.mail import send_mail
# Create your views here.


class Register(APIView):

    def post(self, request, format=None):
        serilaizer = ProfileSerializer(data=request.data)
        if serilaizer.is_valid():
            serilaizer.save()
            return Response(serilaizer.data, status=status.HTTP_200_OK)
        else:
            return Response(serilaizer.errors, status=status.HTTP_400_BAD_REQUEST)


class UserProfile(APIView):

    permission_classes = [IsAuthenticated]

    def get(self, request, format=None):
        user = request.user
        serializer = GetProfileSerializer(Profile.objects.get(id=user.id))
        return Response(serializer.data, status=status.HTTP_200_OK)

def otpgen():
    otp=""
    for i in range(4):
        otp+=str(r.randint(1,9))
    return otp


class SendOTP(APIView):

    def post(self, request, format=None):
        newdata = request.data
        try:
            user = Profile.objects.get(email=newdata["email"])
            otp_digit = otpgen()
            newotp, created = otp.objects.get_or_create(user = user)
            newotp.otp = otp_digit
            newotp.save()
            subject = 'Password Change'
            message = f'Hi {user.first_name}, Your OTP is {otp_digit}'
            recipient_list = [user.email,]
            email_from = settings.EMAIL_HOST_USER
            send_mail(subject, message, email_from, recipient_list)
            return Response({"message": "OTP SENT Successfully"}, status=status.HTTP_200_OK)

        except Exception as e :
            print(e)
            return Response({"message": "Please enter valid email"}, status=status.HTTP_400_BAD_REQUEST)
        
class ChangePassword(APIView):
    
    def post(self, request, format=None):
        newdata = request.data
        try:
            otp_object = otp.objects.get(otp=newdata["otp"])
            user = Profile.objects.get(id=otp_object.user.id)
            user.set_password(newdata["password"])
            user.save()
            otp_object.delete()
            return Response({"message": "Password Changed !!"}, status=status.HTTP_200_OK)     
        except:
            return Response({"message":"Invalid OTP !!"}, status=status.HTTP_400_BAD_REQUEST)
        
