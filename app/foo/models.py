from django.db import models

class Bar(models.Model):
    """Bar model with file upload"""

    title = models.CharField(max_length=100)
    description = models.TextField()

    image = models.FileField(upload_to='bar_uploads')
