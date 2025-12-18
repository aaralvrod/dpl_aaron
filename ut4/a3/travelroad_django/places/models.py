from django.db import models

class Place(models.Model):
    name = models.CharField(max_length=255)
    visited = models.BooleanField()

    class Meta:
        db_table = "places"

    def __str__(self):
        return self.name
