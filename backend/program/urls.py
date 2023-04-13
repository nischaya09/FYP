from django.urls import path
from .views import GetPrograms, GetSubPrograms, GetDescription

urlpatterns = [
    path("all/", GetPrograms.as_view(), name="all"),
    path("<int:id>/all/", GetSubPrograms.as_view(), name="subprograms"),
    path("sub/<int:id>/", GetDescription.as_view(), name="descriptions")
]

