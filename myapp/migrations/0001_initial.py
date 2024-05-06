# Generated by Django 4.0.1 on 2024-03-16 06:11

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Course',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('course_name', models.CharField(max_length=50)),
                ('duration', models.CharField(max_length=10)),
            ],
        ),
        migrations.CreateModel(
            name='Department',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('dept_name', models.CharField(max_length=50)),
                ('description', models.CharField(max_length=300)),
            ],
        ),
        migrations.CreateModel(
            name='Login',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('username', models.CharField(max_length=30)),
                ('password', models.CharField(max_length=30)),
                ('type', models.CharField(max_length=20)),
            ],
        ),
        migrations.CreateModel(
            name='Staff',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('staff_name', models.CharField(max_length=50)),
                ('designation', models.CharField(max_length=30)),
                ('staff_photo', models.CharField(max_length=30)),
                ('staff_email', models.CharField(max_length=30)),
                ('staff_phone', models.CharField(max_length=30)),
                ('gender', models.CharField(max_length=30)),
                ('staff_house', models.CharField(max_length=40)),
                ('staff_location', models.CharField(max_length=50)),
                ('staff_pincode', models.CharField(max_length=10)),
                ('staff_dob', models.DateField()),
                ('staff_education', models.CharField(max_length=200)),
                ('staff_experience', models.CharField(max_length=200)),
                ('DEPARTMENT', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='myapp.department')),
                ('LOGIN', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='myapp.login')),
            ],
        ),
        migrations.CreateModel(
            name='Subject',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('subject_name', models.CharField(max_length=30)),
                ('sem', models.CharField(max_length=10)),
                ('COURSE', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='myapp.course')),
                ('STAFF', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='myapp.staff')),
            ],
        ),
        migrations.CreateModel(
            name='Timetable',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('sem', models.CharField(max_length=30)),
                ('Day', models.CharField(max_length=30)),
                ('COURSE', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='myapp.course')),
                ('SUBJECT_1', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='sub_1', to='myapp.subject')),
                ('SUBJECT_2', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='sub_2', to='myapp.subject')),
                ('SUBJECT_3', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='sub_3', to='myapp.subject')),
                ('SUBJECT_4', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='sub_4', to='myapp.subject')),
                ('SUBJECT_5', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='sub_5', to='myapp.subject')),
                ('SUBJECT_6', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='sub_6', to='myapp.subject')),
            ],
        ),
        migrations.CreateModel(
            name='Student',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('student_name', models.CharField(max_length=30)),
                ('student_photo', models.CharField(max_length=30)),
                ('student_email', models.CharField(max_length=30)),
                ('student_phone', models.CharField(max_length=30)),
                ('sem', models.CharField(max_length=10)),
                ('parent_name', models.CharField(max_length=30)),
                ('gender', models.CharField(max_length=30)),
                ('student_house', models.CharField(max_length=40)),
                ('student_location', models.CharField(max_length=40)),
                ('student_pincode', models.CharField(max_length=10)),
                ('student_dob', models.DateField()),
                ('COURSE', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='myapp.course')),
                ('DEPARTMENT', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='myapp.department')),
                ('LOGIN', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='myapp.login')),
            ],
        ),
        migrations.CreateModel(
            name='Feedback',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('desc', models.CharField(max_length=100)),
                ('date', models.DateField()),
                ('FROM', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='myapp.login')),
            ],
        ),
        migrations.AddField(
            model_name='course',
            name='DEPARTMENT',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='myapp.department'),
        ),
        migrations.CreateModel(
            name='Chat',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('date', models.DateField()),
                ('desc', models.CharField(max_length=100)),
                ('FROM', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='from_id', to='myapp.login')),
                ('TO', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='to_id', to='myapp.login')),
            ],
        ),
        migrations.CreateModel(
            name='Attendance',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('date', models.DateField()),
                ('time', models.TimeField()),
                ('STUDENT', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='myapp.student')),
                ('SUBJECT', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='myapp.subject')),
                ('TIMETABLE', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='myapp.timetable')),
            ],
        ),
    ]
