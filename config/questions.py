'''
Author:     Abubaker Ashfaq

Copyright (c) 2024-2026 Abubaker Ashfaq

License:    MIT License
            https://opensource.org/license/mit
            

Modified by: Abubaker Ashfaq (https://github.com/Abubakerashfaq), 2026

version:    26.01.20.5.08
'''


###################################################### APPLICATION INPUTS ######################################################


# >>>>>>>>>>> Easy Apply Questions & Inputs <<<<<<<<<<<

# Give an relative path of your default resume to be uploaded. If file in not found, will continue using your previously uploaded resume in LinkedIn.
default_resume_path = "all resumes/default/resume.pdf"      # (In Development)

# What do you want to answer for questions that ask about years of experience you have, this is different from current_experience? 
years_of_experience = "1"          # A number in quotes Eg: "0","1","2","3","4", etc.

# Do you need visa sponsorship now or in future?
require_visa = "No"               # "Yes" or "No"

# What is the link to your portfolio website, leave it empty as "", if you want to leave this question unanswered
website = "https://github.com/Abubakerashfaq"                   # "www.example.bio" or "" and so on....

# Please provide the link to your LinkedIn profile.
linkedIn = ""                      # TODO: your LinkedIn URL, e.g. "https://www.linkedin.com/in/example"

# Do you ALREADY have permission to work in the country you are applying to? (Eg: citizen, permanent resident, or a valid work visa such as H-1B or OPT)
# This is NOT `require_visa`, which asks whether you need sponsorship. Someone on a valid work visa answers "Yes" to both.
legally_authorized = "Yes"         # "Yes" or "No"

# What is the status of your citizenship? # If left empty as "", tool will not answer the question. However, note that some companies make it compulsory to be answered
# Valid options are: "U.S. Citizen/Permanent Resident", "Non-citizen allowed to work for any employer", "Non-citizen allowed to work for current employer", "Non-citizen seeking work authorization", "Canadian Citizen/Permanent Resident" or "Other"
us_citizenship = "U.S. Citizen/Permanent Resident"



## SOME ANNOYING QUESTIONS BY COMPANIES 🫠 ##

# What to enter in your desired salary question (American and European), What is your expected CTC (South Asian and others)?, only enter in numbers as some companies only allow numbers,
desired_salary = 1200000          # 80000, 90000, 100000 or 120000 and so on... Do NOT use quotes
'''
Note: If question has the word "lakhs" in it (Example: What is your expected CTC in lakhs), 
then it will add '.' before last 5 digits and answer. Examples: 
* 2400000 will be answered as "24.00"
* 850000 will be answered as "8.50"
And if asked in months, then it will divide by 12 and answer. Examples:
* 2400000 will be answered as "200000"
* 850000 will be answered as "70833"
'''

# What is your current CTC? Some companies make it compulsory to be answered in numbers...
current_ctc = 800000            # 800000, 900000, 1000000 or 1200000 and so on... Do NOT use quotes
'''
Note: If question has the word "lakhs" in it (Example: What is your current CTC in lakhs), 
then it will add '.' before last 5 digits and answer. Examples: 
* 2400000 will be answered as "24.00"
* 850000 will be answered as "8.50"
# And if asked in months, then it will divide by 12 and answer. Examples:
# * 2400000 will be answered as "200000"
# * 850000 will be answered as "70833"
'''

# (In Development) # Currency of salaries you mentioned. Companies that allow string inputs will add this tag to the end of numbers. Eg: 
# currency = "INR"                 # "USD", "INR", "EUR", etc.

# What is your notice period in days?
notice_period = 30                   # Any number >= 0 without quotes. Eg: 0, 7, 15, 30, 45, etc.
'''
Note: If question has 'month' or 'week' in it (Example: What is your notice period in months), 
then it will divide by 30 or 7 and answer respectively. Examples:
* For notice_period = 66:
  - "66" OR "2" if asked in months OR "9" if asked in weeks
* For notice_period = 15:"
  - "15" OR "0" if asked in months OR "2" if asked in weeks
* For notice_period = 0:
  - "0" OR "0" if asked in months OR "0" if asked in weeks
'''

# Your LinkedIn headline in quotes Eg: "Software Engineer @ Google, Masters in Computer Science", "Recent Grad Student @ MIT, Computer Science"
linkedin_headline = "Computer Science Student @ Nova Southeastern University | AI & Cybersecurity Minors | Former Microsoft Tech Acceleration Intern" # "Headline" or "" to leave this question unanswered

# Your summary in quotes, use \n to add line breaks if using single quotes "Summary".You can skip \n if using triple quotes """Summary"""
linkedin_summary = """
Computer Science student at Nova Southeastern University (B.S. expected May 2027) with minors in Artificial Intelligence and Cybersecurity.
Software engineering and Microsoft Tech Acceleration internship experience building Python and JavaScript automation, web scraping pipelines, REST API integrations, and AWS/Azure cloud pipelines.
Projects include a full-stack React + Flask flashcard app, a self-hosted Ollama AI assistant, and an encrypted client-server file transfer tool.
"""

'''
Note: If left empty as "", the tool will not answer the question. However, note that some companies make it compulsory to be answered. Use \n to add line breaks.
''' 

# Your cover letter in quotes, use \n to add line breaks if using single quotes "Cover Letter".You can skip \n if using triple quotes """Cover Letter""" (This question makes sense though)
cover_letter = """
Cover Letter
"""
# Information about you that the AI can use when answering application questions.
# Put anything an answer might need here, for example: name, years of experience,
# key skills, location, work authorization, and so on. Use \n for line breaks.
user_information_all = """
Name: Abubaker Ashfaq
Phone: 954-401-0355
Email: Abubakerashfaq0@gmail.com
GitHub: github.com/Abubakerashfaq
Location: Pembroke Pines, FL

Education: Nova Southeastern University, Ft. Lauderdale, FL. B.S. in Computer Science, minors in Artificial Intelligence and Cybersecurity. GPA 3.5. Aug 2022 - May 2027 (expected).
Relevant coursework: Data Structures & Algorithms, OOP, Computer Architecture, Operating Systems, Database Systems, Discrete Math, Statistics.

Experience:
- Tech Acceleration Intern, Microsoft & Nova Southeastern University, Davie, FL (Hybrid), Aug 2024 - June 2025. Designed a technical curriculum with Microsoft on emerging tech and digital literacy delivered across Broward, Palm Beach, and Miami-Dade counties; implemented cloud storage and processing pipelines for 3D scan data using AWS and Microsoft Azure; led photogrammetry and 3D modeling workshops with Meshroom and Blender.
- Software Engineering Intern, Nova Southeastern University, Ft. Lauderdale, FL (Hybrid), Jan 2024 - Aug 2024. Developed and maintained Python and JavaScript applications automating data collection, processing, and reporting; built web scraping pipelines and integrated third-party REST APIs; debugged issues across the stack and deployed fixes that reduced downtime and improved performance.
- IT Support & Program Coordinator, Boys & Girls Clubs of America, Ft. Lauderdale, FL, Jan 2022 - Feb 2025. First point of contact for IT support (workstations, peripherals, lab computers); designed a coding bootcamp curriculum on web development and software engineering fundamentals; taught Python and Java; built educational games in Unity and Scratch.
- Disney College Program, Walt Disney World, Orlando, FL, Jan 2025 - June 2025. High-volume guest-facing role at Magic Kingdom and Hollywood Studios.

Projects:
- Local AI Assistant (Ollama, LLMs, Python), 2025: self-hosted private/offline AI assistant; customized open-source LLMs with system prompts and model configurations.
- Flashcard Web App (React, Vite, Flask, SQLite, REST API), 2025-2026: full-stack app with RESTful CRUD endpoints over a normalized schema.
- Secure File Transfer Application (Python, Cryptography, Sockets), 2025: client-server tool with end-to-end symmetric encryption and checksum-based integrity verification.

Skills:
Languages: Python, Java, JavaScript, SQL, Bash, LaTeX
Frameworks & Libraries: React.js, Vite, Flask, Node.js
Cloud & Tools: AWS, Azure, Ollama, Git, Linux, Postman, SQLite, Blender, Meshroom, Unity
Concepts: REST APIs, OOP, Data Structures, Web Scraping, Database Normalization, ACID Properties
"""
'''
Note: If left empty as "", the tool will not answer the question. However, note that some companies make it compulsory to be answered. Use \n to add line breaks.
''' 

# Name of your most recent employer
recent_employer = "Nova Southeastern University" # "", "Lala Company", "Google", "Snowflake", "Databricks"

# Example question: "On a scale of 1-10 how much experience do you have building web or mobile applications? 1 being very little or only in school, 10 being that you have built and launched applications to real users"
confidence_level = "8"             # Any number between "1" to "10" including 1 and 10, put it in quotes ""
##



# >>>>>>>>>>> RELATED SETTINGS <<<<<<<<<<<

## Allow Manual Inputs
# Should the tool pause before every submit application during easy apply to let you check the information?
pause_before_submit = True         # True or False, Note: True or False are case-sensitive
'''
Note: Will be treated as False if `run_in_background = True`
'''

# Should the tool pause if it needs help in answering questions during easy apply?
# Note: If set as False will answer randomly...
pause_at_failed_question = True    # True or False, Note: True or False are case-sensitive
'''
Note: Will be treated as False if `run_in_background = True`
'''
##

# Do you want to overwrite previous answers?
overwrite_previous_answers = False # True or False, Note: True or False are case-sensitive







############################################################################################################
# --- Load user settings saved by the local control panel (user_config.json).
# --- No-op if that file is absent: values fall back to the defaults above.
from config import _overrides as _o
_o.apply(__name__, globals())
############################################################################################################