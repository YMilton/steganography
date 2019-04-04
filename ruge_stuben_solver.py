# Illustrates the selection of Coarse-Fine (CF) 
# splittings in Classical AMG.
import numpy
from pyamg import ruge_stuben_solver
from scipy.io import loadmat
from scipy.io import savemat

data = loadmat('Mat/NcutData.mat')
Acsc = data['NcutMatrix']            # matrix
Acsr = Acsc.tocsr()
mls = ruge_stuben_solver(Acsr, max_levels=6, max_coarse=150, CF='RS', keep=True)
#mls = ruge_stuben_solver(Acsr, keep=True)

'''
Parameters
    #----------
    A : csr_matrix
        Square matrix in CSR format
    strength : ['symmetric', 'classical', 'evolution', None]
        Method used to determine the strength of connection between unknowns
        of the linear system.  Method-specific parameters may be passed in
        using a tuple, e.g. strength=('symmetric',{'theta' : 0.25 }). If
        strength=None, all nonzero entries of the matrix are considered strong.
    CF : {string} : default 'RS'
        Method used for coarse grid selection (C/F splitting)
        Supported methods are RS, PMIS, PMISc, CLJP, and CLJPc
    presmoother : {string or dict}
        Method used for presmoothing at each level.  Method-specific parameters
        may be passed in using a tuple, e.g.
        presmoother=('gauss_seidel',{'sweep':'symmetric}), the default.
    postsmoother : {string or dict}
        Postsmoothing method with the same usage as presmoother
    max_levels: {integer} : default 10
        Maximum number of levels to be used in the multilevel solver.
    max_coarse: {integer} : default 500
        Maximum number of variables permitted on the coarse grid.
    keep: {bool} : default False
        Flag to indicate keeping extra operators in the hierarchy for
        diagnostics.  For example, if True, then strength of connection (C) and
        tentative prolongation (T) are kept.
    Returns
    -------
    ml : multilevel_solver
        Multigrid hierarchy of matrices and prolongation operators
'''


# The CF splitting, 1 == C-node and 0 == F-node
level1 = mls.levels[0].splitting
level2 = mls.levels[1].splitting
level3 = mls.levels[2].splitting
level4 = mls.levels[3].splitting
level5 = mls.levels[4].splitting
#C_nodes = splitting == 1
#F_nodes = splitting == 0

#savemat('Mat/MLSMat.mat', {'mls':mls})
savemat('Mat/RSSMat.mat', {'level1':level1,'level2':level2,'level3':level3,'level4':level4,'level5':level5})
#savemat('RSSMat.mat', {'splitting':splitting, 'C_nodes':C_nodes, 'F_nodes':F_nodes})