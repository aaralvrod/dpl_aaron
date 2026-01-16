from django.urls import path

from . import views

app_name = 'places'

urlpatterns = [
    path('', views.index, name='index'),
    path('wished/', views.wished_places, name='wished_places'),
    path('visited/', views.visited_places, name='visited_places'),
]
