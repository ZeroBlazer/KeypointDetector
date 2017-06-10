import scipy.io
import numpy as np

data = scipy.io.loadmat("./data/MODEL_DATASET/airplane_4.mat")

for i in data:
    if '__' not in i and 'readme' not in i:
        np.savetxt(("./data/model_csv/file.csv"),data[i],delimiter=',')