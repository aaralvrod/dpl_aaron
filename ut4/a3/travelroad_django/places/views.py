from django.http import HttpResponse
from django.template import loader

from .models import Place


def index(request):
    template = loader.get_template('places/index.html')
    context = {
        'wished': Place.objects.filter(visited=False),
        'visited': Place.objects.filter(visited=True),
    }
    return HttpResponse(template.render(context, request))


def wished(request):
    template = loader.get_template('places/wished.html')
    wished = Place.objects.filter(visited=False)
    context = {
        'wished': wished,
    }
    return HttpResponse(template.render(context, request))


def visited(request):
    template = loader.get_template('places/visited.html')
    visited = Place.objects.filter(visited=True)
    context = {
        'visited': visited,
    }
    return HttpResponse(template.render(context, request))
