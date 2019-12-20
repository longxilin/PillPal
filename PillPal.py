import pytesseract
from PIL import Image

#Unnessecary once DL OCF is implemented
pytesseract.pytesseract.tesseract_cmd = r'C:\Program Files\Tesseract-OCR\tesseract.exe'

#Import image obtained from imgCapture
img = Image.open('test1.jpg')

label = pytesseract.image_to_string(img, lang='eng')
#print(label)
#MUST EXPAND DICTONARY FOR MORE KEYWORDS
dict = {'ONCE': 1, 'DAILY': 1, 'TWICE': 2, 'THREE': 3}

#[1]-MEDICATION
#[2]-INSTRUCTION LABEL
#[3]-QUANTITY
#[4]-# PILLS/DAY
medication = []

#User manually input info or extract from img
def userInput():
	result = input('Would you like to manually input the information? (Y/N)\n')
	return result

# Identify the instructions on the label
def findDosage(label):
    inst = label.split('\n\n')
    for items in inst:
        if 'TAKE' in items.upper():
            temp = ' '.join(items.upper().splitlines())
            temp = list(temp.partition('TAKE'))
            del temp[0]
            dosage = ''.join(temp)
    return dosage

# Identify what medication is in the bottle ###Reference Drug Database for additional info###
def findMed(label):
    for items in label.splitlines():
        if 'MG' in items.upper():
            temp = items.upper()
            temp = list(temp.partition('MG'))
            del temp[-1]
            med = ''.join(temp)
    return med

# Number of pills patient takes in a day ###Total num of notifs###
def numPills(dosage):
    wordvalue = []
    for item in dosage.split():
        if item.upper() in dict:
            wordvalue.append(dict[item.upper()])
    if (sum(wordvalue) == 0):
        wordvalue.append(1)
    pills = sum([int(i)for i in dosage.split() if i.isdigit()]) * sum(wordvalue)
    return pills

# Number of pills in the bottle ###Alert if patient needs refil###
def findQuantity(label):
    flag = -1
    for items in label.splitlines():
        if 'QTY:' in items.upper():
            flag = 0
            temp = items.upper().split()
            index = temp.index('QTY:')
            qty = (temp[index+1])
    if flag == -1:
        qty = input('Enter the amount of pills on the label\n')
    return qty

'''
# Number of refills patient has left 
def refills(label):
	for items in label.splitlines():
		if 'REFILLS' in items.upper():
'''

while True: 
    result = userInput()

    if (result.upper() == 'Y'):
        dosage = input('Enter the instructions seen on the label\n').upper()
        med = input('Enter the name of your medication with dosage MG\n').upper()
        qty = input('Enter the amount of pills on the label\n')
        pills = numPills(dosage)
        medication.append([med,dosage,qty,pills])
    elif(result.upper() == 'P'):
        print(medication)
    elif(result.upper() == 'N'):
        dosage = findDosage(label)
        med = findMed(label)
        qty = findQuantity(label)
        pills = numPills(findDosage(label))
        medication.append([med,dosage,qty,pills])
    
    print('Please confirm the following information is correct:')
    print(medication[-1])
    # add = input('Add another medication? (Y)\n')
    # if (add.upper() != 'Y'):
    #     break

    # delete = input('Delete a medication?')
    