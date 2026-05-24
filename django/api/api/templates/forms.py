from django import forms

class ContactForm(forms.Form):
    name = forms.CharField(max_length=100, required=True, label='Your Name')
    email = forms.EmailField(label='Your Name')
    message = forms.CharField(widget=forms.Textarea, label='Your Name')
