from django.db import models
from notification.models import Notification
from django.dispatch import receiver
import os

# Create your models here.

def upload_path(instance, filname):
    return '/'.join(['program_images', str(instance.name), filname])

def desc_upload_path(instance, filname):
    return '/'.join(['program_images', str(instance.title), filname])

class Program(models.Model):
    name = models.CharField(max_length=50, blank=False)
    image = models.ImageField(max_length=100, blank=False, null=True, upload_to=upload_path)

    def save(self, *args, **kwargs):
        if self._state.adding == True :
            notify = Notification(message="New Program "+ self.name+" has been added")
            notify.save()
            super(Program, self).save(*args, **kwargs)
        else:
            super(Program, self).save(*args, **kwargs) 

    def __str__(self):
        return self.name 

@receiver(models.signals.post_delete, sender=Program)
def auto_delete_file_on_delete(sender, instance, **kwargs):
    if instance.image:
        if os.path.isfile(instance.image.path):
            os.remove(instance.image.path)

@receiver(models.signals.pre_save, sender=Program)
def auto_delete_file_on_change(sender, instance, **kwargs):
    if not instance.pk:
        return False

    try:
        old_file = Program.objects.get(pk=instance.pk).image
    except Program.DoesNotExist:
        return False

    new_file = instance.image
    if not old_file == new_file:
        if os.path.isfile(old_file.path):
            os.remove(old_file.path)


class SubProgram(models.Model):
    program = models.ForeignKey(Program, on_delete=models.CASCADE)
    name = models.CharField(max_length=50, blank=False)
    image = models.ImageField(max_length=100, blank=False, null=True, upload_to=upload_path)
    
    def save(self, *args, **kwargs):
        if self._state.adding == True :
            notify = Notification(message="New Sub Program "+ self.name+" has been added " + "in " + self.program.name)
            notify.save()
            super(SubProgram, self).save(*args, **kwargs)
        else:
            super(SubProgram, self).save(*args, **kwargs) 

    def __str__(self):
        return self.name

@receiver(models.signals.post_delete, sender=SubProgram)
def auto_delete_file_on_delete(sender, instance, **kwargs):
    if instance.image:
        if os.path.isfile(instance.image.path):
            os.remove(instance.image.path)

@receiver(models.signals.pre_save, sender=SubProgram)
def auto_delete_file_on_change(sender, instance, **kwargs):
    if not instance.pk:
        return False

    try:
        old_file = SubProgram.objects.get(pk=instance.pk).image
    except SubProgram.DoesNotExist:
        return False

    new_file = instance.image
    if not old_file == new_file:
        if os.path.isfile(old_file.path):
            os.remove(old_file.path)

class Description(models.Model):
    sub_program = models.ForeignKey(SubProgram, on_delete=models.CASCADE)
    title = models.CharField(max_length=100, blank=False)
    desc = models.TextField()
    image = models.ImageField(max_length=100, blank=False, null=True, upload_to=desc_upload_path)

    def __str__(self):
        return self.title

@receiver(models.signals.post_delete, sender=Description)
def auto_delete_file_on_delete(sender, instance, **kwargs):
    if instance.image:
        if os.path.isfile(instance.image.path):
            os.remove(instance.image.path)

@receiver(models.signals.pre_save, sender=Description)
def auto_delete_file_on_change(sender, instance, **kwargs):
    if not instance.pk:
        return False

    try:
        old_file =  Description.objects.get(pk=instance.pk).image
    except Description.DoesNotExist:
        return False

    new_file = instance.image
    if not old_file == new_file:
        if os.path.isfile(old_file.path):
            os.remove(old_file.path)