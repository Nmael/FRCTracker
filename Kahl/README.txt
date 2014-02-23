For Hough Transforms:

Run "hough_stough.m"
-->Uses the following functions:
	-clean_mask_hough.m
	-drawParallelLines.m
-->Uses images from the directory:
	-"/pix"

-->Input: Change the image name at the beginning of the file to change input
-->Output: Uses imshow to show masks and results
	



For image subtraction:

Run "imsubtract.m"
-->Uses the following class:
	-Image.m
-->Uses the following functions:
	-clean_mask_imsubtract.m
-->Uses images from directory:
	-"/QF2-1_5160-5240"
	-Can be changed in the code

-->Input: Images from specified directory, numbered consecutively
-->Outputs: 
	-Saves bounding boxed images to directory "/boxed"
	-Saves centroid information to "centroids.mat"
	--> Format for each row:
		<centroid_row> <centroid_col> <frame_number>