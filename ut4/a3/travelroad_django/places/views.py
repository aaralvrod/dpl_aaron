from django.http import HttpResponse
from django.template import loader

from .models import Place


def index(request):
    return HttpResponse(template.render(context, request))

def whised(request):
    wished = Place.objects.filter(visited=False)
    context = {
        'wished': wished,
    }
    return HttpResponse(template.render(context, request))

def visited(request):
    visited = Place.objects.filter(visited=True)
    context = {
        'visited': visited,
    }
    return HttpResponse(template.render(context, request))