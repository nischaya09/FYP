from django.db import models
from notification.models import Notification
from django.dispatch import receiver
from user.models import Profile
import os

# Create your models here.
def upload_path(instance, filname):
    return '/'.join(['product_images', str(instance.name), filname])


class GymProduct(models.Model):
    name = models.CharField(max_length=50, blank=False, unique=True)
    image = models.ImageField(max_length=100, blank=False, null=True, upload_to=upload_path)
    price = models.IntegerField(blank=False)
    subtitle = models.CharField(max_length=50, blank=True, null=True)
    description = models.TextField(blank=False, null=True)

    def save(self, *args, **kwargs):
        if self._state.adding == True :
            notify = Notification(message="New Product "+ self.name+" has been added")
            notify.save()
            super(GymProduct, self).save(*args, **kwargs)
        else:
            super(GymProduct, self).save(*args, **kwargs) 

    def __str__(self):
        return self.name 

@receiver(models.signals.post_delete, sender=GymProduct)
def auto_delete_file_on_delete(sender, instance, **kwargs):
    if instance.image:
        if os.path.isfile(instance.image.path):
            os.remove(instance.image.path)

@receiver(models.signals.pre_save, sender=GymProduct)
def auto_delete_file_on_change(sender, instance, **kwargs):
    if not instance.pk:
        return False

    try:
        old_file = GymProduct.objects.get(pk=instance.pk).image
    except GymProduct.DoesNotExist:
        return False

    new_file = instance.image
    if not old_file == new_file:
        if os.path.isfile(old_file.path):
            os.remove(old_file.path)


class ProductBuyerInfo(models.Model):
    user = models.ForeignKey(Profile, on_delete=models.CASCADE, limit_choices_to={"is_superuser": False})
    product = models.ForeignKey(GymProduct, on_delete=models.CASCADE)
    date = models.DateField(auto_now=True)


    def __str__(self):
        return self.user.first_name + " "+ self.user.last_name + " wants to buy " + self.product.name 
