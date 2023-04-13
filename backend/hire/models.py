from django.db import models
from django.core.validators import RegexValidator
from django.dispatch import receiver
import os
from user.models import Profile

# Create your models here.
def upload_path(instance, filname):
    return '/'.join(['coach_images', str(instance.name), filname])


class Coach(models.Model):
    name = models.CharField(max_length=50, blank=False)
    email = models.EmailField(blank=False, unique=True)
    phone_regex = RegexValidator(
        regex=r"^\d{10,10}$", message="Phone number must be 10 digits"
    )
    phone = models.CharField(
        validators=[phone_regex], max_length=10, blank=False, unique=True
    )
    image = models.ImageField(max_length=100, blank=False, null=True, upload_to=upload_path)

    def __str__(self):
        return self.name

@receiver(models.signals.post_delete, sender=Coach)
def auto_delete_file_on_delete(sender, instance, **kwargs):
    if instance.image:
        if os.path.isfile(instance.image.path):
            os.remove(instance.image.path)

@receiver(models.signals.pre_save, sender=Coach)
def auto_delete_file_on_change(sender, instance, **kwargs):
    if not instance.pk:
        return False

    try:
        old_file = Coach.objects.get(pk=instance.pk).image
    except Coach.DoesNotExist:
        return False

    new_file = instance.image
    if not old_file == new_file:
        if os.path.isfile(old_file.path):
            os.remove(old_file.path)


class HireInfo(models.Model):
    user = models.ForeignKey(Profile, on_delete=models.CASCADE, limit_choices_to={"is_superuser": False})
    coach = models.ForeignKey(Coach, on_delete=models.CASCADE)
    date = models.DateField(auto_now=True)


    def __str__(self):
        return self.user.first_name + " "+ self.user.last_name + " wants to hire " + self.coach.name 