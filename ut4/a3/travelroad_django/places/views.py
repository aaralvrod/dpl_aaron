from django.shortcuts import render
from .models import Place

def index(request):
    return render(request, 'place/index.html', {})

def wished_places(request):
    wished = Place.objects.filter(visited=False)
    return render(request, 'place/wished.html', {'wished': wished})

def visited_places(request):
    visited = Place.objects.filter(visited=True)
    return render(request, 'place/visited.html', {'visited': visited})