from django.urls import path
from .views import AddFeedback

# from rest_framework import SimpleRouer

urlpatterns = [
    path("add/", AddFeedback.as_view(), name="add"),
]
