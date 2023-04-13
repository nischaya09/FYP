from django.urls import path
from .views import Register, SendOTP, UserProfile, ChangePassword
from rest_framework_simplejwt.views import TokenObtainPairView, TokenRefreshView

# from rest_framework import SimpleRouer

urlpatterns = [
    path("login/", TokenObtainPairView.as_view(), name="login"),
    path("login/refresh/", TokenRefreshView.as_view(), name="login_refresh"),
    path("register/", Register.as_view(), name="register"),
    path("profile/", UserProfile.as_view(), name="profile"),
    path("sendotp/", SendOTP.as_view(), name="sendotp"),
    path("newpassword/", ChangePassword.as_view(), name="newpassword")
]
