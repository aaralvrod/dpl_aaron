from django.urls import path

from . import views

app_name = 'places'

urlpatterns = [
    path('', views.index, name='index'),
    path('whised/', views.whised, name='whised'),
    path('visited/', views.visited, name='visited'),
]
