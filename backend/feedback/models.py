from django.db import models
from user.models import Profile

# Create your models here.
class Feedback(models.Model):
    user = models.ForeignKey(Profile, on_delete=models.CASCADE, limit_choices_to={"is_superuser": False})
    type = models.CharField(max_length=50, blank=False,  choices={("Login Trouble", "Login Trouble"), ("Phone Number Related", "Phone Number Related"),("Personal Profile", "Personal Profile"), ("Other Issues", "Other Issues" ), ("Suggestions", "Suggestions")},)
    feed = models.TextField()

    def __str__(self):
        return self.feed
