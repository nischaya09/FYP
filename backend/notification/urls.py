from django.urls import path
from .views import GetNotifications, NumberofNotifications

urlpatterns = [
    path("all/", GetNotifications.as_view(), name="notifications"),
    path("count/", NumberofNotifications.as_view(), name="count" )
]
