import numpy as np
import cv2
import os

#Image Capture
cap = cv2.VideoCapture(0)


while True:
	ret, frame = cap.read()
	flipped = cv2.flip(frame, 1)
	cv2.rectangle(flipped,(150,160),(510,320),(255,255,255),1)

	cv2.imshow('frame', flipped)

	if cv2.waitKey(1) & 0xFF == ord(' '):
		cv2.imwrite('capture.jpg',flipped)
		break
 
cap.release()
cv2.destroyAllWindows()


img = cv2.imread("capture.jpg")
crop_img = img[160:320,150:510]

cv2.imshow('cropped',crop_img)
cv2.imwrite('output.jpg',crop_img)
try: 
    os.remove('capture.jpg')
except: 
	pass
cv2.waitKey(0)