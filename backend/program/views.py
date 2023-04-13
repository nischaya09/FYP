from .models import Description, Program, SubProgram
from rest_framework import viewsets, status
from .serializers import ProgramSerializer, SubProgramSerializer, DescriptionSerializer
from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework.permissions import IsAuthenticated


# Create your views here.

class GetPrograms(APIView):

    permission_classes = [IsAuthenticated]

    def get(self, request):
        serializer = ProgramSerializer(Program.objects.all(), many=True, context= {'request': request})
        return Response(serializer.data, status=status.HTTP_200_OK)

class GetSubPrograms(APIView):

    permission_classes = [IsAuthenticated]

    def get(self, request, id):
        serializer = SubProgramSerializer(SubProgram.objects.filter(program_id=id), many=True, context= {'request': request})
        return Response(serializer.data, status=status.HTTP_200_OK)

class GetDescription(APIView):

    permission_classes = [IsAuthenticated]

    def get(self, request, id):
        serializer = DescriptionSerializer(Description.objects.get(sub_program_id=id), many=False, context= {'request': request})
        return Response(serializer.data, status=status.HTTP_200_OK)




