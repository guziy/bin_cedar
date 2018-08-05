import os 
import sys
import time

folder = os.getcwd()

backup_folder = "../backup"

if not os.path.isdir(backup_folder):
	os.mkdir(backup_folder)

if not os.path.basename(folder).lower().endswith("samples"):
	print("Sorry I can work only in Samples folder, exiting...")
	sys.exit(-1)



print("Working in the following path: {f}".format(f=folder))

if raw_input("Continue?[y/n]: ").lower().strip().startswith("y"):
	for month_folder in os.listdir(folder):
		
		if not os.path.isdir(month_folder):
			continue


		# Get names of the rpn files
		file_names = os.listdir(os.path.join(folder, month_folder))
		
		file_paths = [os.path.join(month_folder, fn) for fn in file_names]

		file_times = [os.path.getmtime(fp) for fp in file_paths]

		# print("Current month folder: {f}".format(f=month_folder))
		
		fp_2_ft = dict(zip(file_paths, file_times))

		weird = False

		for fn in file_names:
			if not (fn.startswith("dm") or fn.startswith("pm")):
				weird = True
				break

		if weird:
			print("Not touching {f}, since it contains unrecognized files: ".format(f=month_folder), file_names)
			continue

		if len(fp_2_ft) == 4:
			# sort in time (asc)
			sorted_pairs = sorted(zip(file_paths, file_times), key=lambda pair: pair[1])
			
			# delete older files
			keep_list = []
			remove_list = []
			for i, (fp, ft) in enumerate(sorted_pairs):
				if i < 2:
					remove_list.append(fp)
				else:
					keep_list.append(fp)

			print("Files to keep: ", keep_list, [time.ctime(fp_2_ft[fp]) for fp in keep_list])
			print("Files to delete: ", remove_list, [time.ctime(fp_2_ft[fp]) for fp in remove_list])

			for fp in remove_list:
				print("{f1} ---> {f2}".format(f1=fp, f2=os.path.join(backup_folder, os.path.basename(fp))))
				os.rename(fp, os.path.join(backup_folder, os.path.basename(fp)))





