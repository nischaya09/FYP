from django.urls import path
from .views import GetCoach, HireCoach



urlpatterns = [
    path("all/", GetCoach.as_view(), name="coaches"),
    path("hire/<int:id>/", HireCoach.as_view(), name="hirecoach")

]
