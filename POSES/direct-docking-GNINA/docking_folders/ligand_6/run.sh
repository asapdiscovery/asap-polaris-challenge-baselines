#BSUB -J run_asap
#BSUB -q gpuqueue
#BSUB -m lt-gpu
#BSUB -gpu "num=1:j_exclusive=yes:mode=shared"
#BSUB -n 1
#BSUB -W 2:00
#BSUB -oo docking_log.out
#BSUB -eo docking_log.err


source ~/.bashrc
module load cuda/12.2
module load singularity/3.2.0-rc1

cd $LS_SUBCWD
pwd

# network device info
ifconfig
ulimit -c 0

# we're running gnina  master:33846ee   Built Jul 24 2023.
singularity run --nv /data/chodera/shared/apptainers/gnina.sif gnina -r SARS-CoV-2-protein.pdb -l ligand_to_dock.sdf --autobox_ligand SARS-CoV-2-ligand-reference.sdf -o docked_SARS-CoV-2.sdf --exhaustiveness 64

singularity run --nv /data/chodera/shared/apptainers/gnina.sif gnina -r MERS-CoV-protein.pdb -l ligand_to_dock.sdf --autobox_ligand MERS-CoV-ligand-reference.sdf -o docked_MERS-CoV.sdf --exhaustiveness 64

echo Done
date
