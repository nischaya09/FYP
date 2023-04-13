from django.urls import path
from .views import GetProducts, GetProductDetail, ProductBuyer

urlpatterns = [
    path("all/", GetProducts.as_view(), name="all"),
    path("<int:pk>/", GetProductDetail.as_view(), name="detail"),
    path("<int:id>/buy/", ProductBuyer.as_view(), name="buyer")
]
