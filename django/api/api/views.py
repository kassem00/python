from django.shortcuts import render, redirect
from .forms import ContactForm

def contact_view(request):
    if request.method == "POST":
        form = ContactForm(request.POST)
        print(form)
 
        if form.is_valid():
            print(form.cleaned_data)
            name = form.cleaned_data["name"]
            email = form.cleaned_data["email"]
            message = form.cleaned_data["message"]

            # Do something useful:
            # send email, save manually, call service, etc.

            return redirect("contact_view_something")

    else:
        form = ContactForm()

    return render(request, "contact.html", {"form": form})




def person(request):
    context = {
            "name" : "kassem",
            "age": "23",
            "skills": ["python", "JS", "SQL"]
            }
    return render(request, 'template_demo.html',context)
