# Qi Cai, Lilian Zhang, Yuanxin Wu, Wenxian Yu, Dewen Hu - A Pose-only Solution to Visual Reconstruction and Navigation

A Pose-only Solution to Visual Reconstruction and Navigation
Qi Cai1†, Lilian Zhang2†, Yuanxin Wu1†*, Wenxian Yu1, Dewen Hu2*

## Abstract

Visual navigation and three-dimensional (3D) scene
reconstruction are essential for robotics to interact with the
surrounding environment. Large-scale scenes and critical
camera motions are great challenges facing the research
community to achieve this goal. We raised a pose-only
imaging geometry framework and algorithms that can help
solve these challenges. The representation is a linear
function of camera global translations, which allows for
efficient and robust camera motion estimation. As a result,
the spatial feature coordinates can be analytically
reconstructed and do not require nonlinear optimization.

## Experiments

of recovering the scene and associated camera poses is
significantly improved by 2-4 orders of magnitude. This
solution might be promising to unlock real-time 3D visual
computing in many forefront applications.
1. Introduction
A visual imaging system maps the 3D real world onto a
two-dimensional image camera plane. One essential task of
computer vision research is to recover a 3D scene and the
camera poses at which the images were taken. As noted by
Marr [1], humans perceive the real world through two main
processes: image feature correspondence, followed by the
computation and understanding of the 3D scene. The
reverse-imaging process of recovering the scene and the
associated camera poses from a set of images, known as
bundle adjustment (BA), is the backbone of simultaneous
localization and mapping or structure from motion, and it
plays a prominent role in computer vision, robotics, and
digital
photogrammetry
applications
[2-6].
BA
is
essentially an iterative nonlinear optimization with respect
to 3D feature coordinates and camera poses (sometimes
including intrinsic camera parameters) [2, 7]; its
performance h 1 eavily depends on initialization [8-13].
However, special but not uncommon camera movements,
such as collinear or small translations, typically lead to
1 1 Shanghai Key Laboratory of Navigation and Location-based Services,
School of Electronic Information and Electrical Engineering, Shanghai
Jiao Tong University, Shanghai, China.
2 College of Intelligent Science and Technology, National University of
Defense Technology, Changsha, China.
† These authors contributed equally to this work.
* Correspondence to: yuanxin.wu@sjtu.edu.cn, dwhu@nudt.edu.cn.
abnormal initialization [7, 12, 14, 15].
Visual computation efficiency and robustness have been
long-standing bottleneck problems in 3D computer vision.
Specifically, the nonlinear optimization of a large-scale BA
has been facing two challenges [3, 10, 11, 16]: benign
initialization and fast solution to the normal equation. For
initialization, an incremental optimization starting from a
two-view BA can be employed [5, 17], or alternatively, the
relative poses between any two views can be used as inputs
for optimally solving first the global rotation and then the
global translation of each view. There exist several efficient
and stable global rotation averaging methods [13, 18-23].
The relative translations can be formulated as


,i j
j
i
j
R



t
t
t
where
i
j


t
t
,
,i j
t
is a relative
translation unit vector between the i-th and j-th views, and
iR  and
it  are the global rotation and translation for the i-th
view, respectively. A direct linear approach by Govindu
[20] proposed a least-squared solution of global translation
to the linear system


,
i j
j
i
j
R



t
t
t
and improved it in
[24]. Recent global translation averaging methods in [12,
15,
25-28]
aimed
to
minimize
the
penalty
of


,i j
j
i
j
R



t
t
t
or its variants. Sim and Hartley [28] and
Moulon et al. [27] formulated the penalty as a L norm.
Wilson and Snavely [12] introduced a 1DSfM method,
which has a one-dimensional preprocessing step to remove
relative translation outliers and uses a non-convex
optimization in the squared chordal form. Ozyesil [29]
pointed out that the L norm is prone to pairwise
translation outliers, and provided a robust penalty with a
least unsquared deviations (LUD) form [15]. Goldstein et
al. [26] described the penalty by the magnitude of the
projection of
i
j

t
t  on the orthogonal complement of
,i j
t
and minimized it by the alternating direction method of
multipliers. Zhuang et al. [25] gave a geometric
interpretation
of
the
above-mentioned
works
and
developed a bilinear angle-based translation averaging
(BATA) method. These methods might suffer from
collinear motion, parallel rigidity [15], and even the local
pure rotation motion. Other recent heuristic methods in
global translation averaging construct different objective
functions from


,i j
j
i
j
R



t
t
t
.  In [14], a global linear

## Method

[30] added directions of features to the above constraint to
help deal with collinear motion. The recent work by Liu et
al. [31] showed that the idea of using feature directions can
well handle the collinear motion, and presented a linear
translation form by calculating a non-linear term directly
based on
,i j
t
. Consequently, the accuracy of current global
translation averaging methods in all the above-mentioned
works depends on that of relative translation.
For a fast solution to the large-scale normal equation,
the main ideas for the last two decades have been full
utilization of the inherent sparsity property of the BA
problem, and the reduction of matrix dimension by the
Schur complement [3, 11, 32, 33]. There are works
reformulating the BA problem by using different
parameterization, such as the parallax angles [11, 31, 34],
to express 3D feature coordinates. However, the
high-dimensional parameter space in the BA problem still
exists. To overcome the memory limit of a computer, the
BA problem was transformed into a number of small-scale
inter-connected BA problems and handled by distributed
computers [8, 10].
Based on the given feature correspondence, Higgins [35]
introduced the concept of essential matrix and invented a
linear eight-point algorithm to recover the two-view pose
and scene structure. The essential equation defining the
essential matrix is a simplification of the two-view imaging
geometry in that it only captures the co-planar relationship
of the camera baseline and the two projection rays, but
loses the depth information [2, 7, 35-37]. It was recently
revealed that the two-view imaging geometry is
equivalently governed by a pair of pose-only constraints,
decoupling camera poses from 3D feature coordinates [36].
In this paper, we find that the multiple-view imaging
geometry can be completely represented by camera poses
and image points, and notably, it is linearly related to
camera global translations (see Fig. 1). Preconditioned on
known global rotations, we give a linear global translation
solution without the need of relative translation that can
deal with the motions of collinear and local pure rotation.
This linear translation relationship is found to be
instrumental in obtaining a nearly optimal initialization for
the subsequent nonlinear optimization. Over 50 data tests
on public datasets show that the proposed algorithms have
considerably eased the challenges of computational
efficiency and robustness in recovering camera poses and
the 3D scene structure.
2. Pose-only imaging geometry
2.1. Depth-pose-only constraint
Consider a 3D feature point


,
,
T
W
W
W
W
x
y
z

X
observed
in n images (or views). For i = 1, 2, …, n, denote by
Figure 1: Principle of the proposed solution. Multiple-view
geometry is equivalently represented by poses and image points,
which is actually a linear global translation constraint. The linear
constraint enables a linear solution to global translations that is
theoretically immune to camera collinear movement and local
pure rotation. 3D feature coordinates are removed from
optimization in pose-only imaging geometry and can be
analytically reconstructed from recovered poses.


,
,1
T
i
i
i
x y

X
the normalized image coordinate of the 3D
feature point in the i-th image (or, alternatively, view i), and
by
iR  and
it  the global rotation and global translation of
the camera when taking the i-th image, respectively. The
projection equation of the 3D feature point
W
X
for the i-th
image can be given by [2, 7]


1
,
1,2,...
=
,
i
i
i
W
i
i
C
C
C
i
R
i
n
z
z



X
X
X
t
(1)
where


,
,
i
i
i
i
C
T
C
C
C
x
y
z

X
is the coordinate of the 3D
feature point in the camera frame corresponding to the i-th
image, and
i
C
z

is the corresponding depth of the
feature point. For m 3D feature points observed in n images,
the multiple-view imaging relationship can be represented
as [2, 7]








,
1
1
,
,
,
w
k
i
i
k i
i
n
k
m i
n
k
m
f
R









，
X
t
X
(2)
where
w
k
X  is the world coordinate of the k-th 3D feature;
iR  and
it  denote the global rotation and translation of the
camera when taking the i-th image, respectively; and
,
k i
X
is the normalized image coordinate of the k-th 3D feature
on the i-th image. It is well known that there is a global
scale ambiguity in recovering camera poses and the 3D
scene structure. For instance, for any rigid transformation
R  and t  at a scale , the projection equation (1) is
always valid for substitutions
i
i
T
R
R R

,


i
i
R



t
t
t ,
and


W
W
R


X
X
+ t
. Therefore, the discussions to
follow are based on global scale ambiguity awareness.
Denote by 

,i j  a pair of views consisting of the i-th and
j-th images. The imaging equation for the view pair 

,i j
is [2, 7]
,
,
j
i
C
C
j
i j
i
i j
z
R
z

X
X + t
(3)
where the relative rotation is
,
T
i j
j
i
R
R R

and the relative
translation is


,i j
j
i
j
R


t
t
t
. Left multiply the
antisymmetric matrix
j





X
on both sides of equation (3),
,
,
i
C
j
i j
i
j
i j
z
R











X
X
X
t
(4)
Taking the magnitude, we get


,
,
,
i
j
i
i j
i
C
i j
j
d
z








X
t
(5)
where
,
,
j
i j
i
i j
R






X
X
. Similarly, left-multiplying the
antisymmetric matrix
,i j
i
R





X
on both sides of equation
(3) yields


,
,
,
,
j
i j
j
i j
i j
i
i j
C
R
d
z








X
t
(6)
Combining equations (3), (5), and (6), the pose-only
constraint for the two-view imaging geometry, called a pair
of pose-only or PPO constraints [36], is obtained as




,
,
,
,
i j
i j
j
i
i j
j
i
i j
d
d
R


X
X
t
(7)
Moreover, it can be proved that the PPO constraint is
equivalent to the two-view imaging geometry [36]. This
equivalency is valid even when there is only a pure rotation
between the two views, namely, in the case of
,
i j


.
Regarding the l-th image (l ≠ j), the view pair 

,i l  also
satisfies the PPO constraint




,
,
,
,
i l
i l
l
i
i l
l
i
i l
d
d
R


X
X
t
(8)
and




,
,
i
i j
i l
i
i
C
d
d
z


(9)
We name the relationship in equation (9) as the depth-equal
constraint of the 3D feature point on the i-th image. Note
that for all n images, there are
n
C   PPO constraints and
n
C
depth-equal constraints, which contain a great deal of
redundancy.
Substitute equation (9) into equation (8),




,
,
,
,
i l
i j
l
i
i l
l
i
i l
d
d
R


X
X
t
(10)
Define a set








,
,
,
,
,
,
i
i
i
i
i
D
d
d
R
i
n i













X
X
t
(11)
which represents a set of constraints that take views  and
 as the left- and right-base views, respectively. As this is
related to poses and depths (which are functions of poses)
only, we name it the depth-pose-only (DPO) constraint set
for the 3D feature point. Note: It can be proved that the
DPO constraint set (11) is equivalent to the projection
equation (1); see Proposition 3 below. That is, For m 3D
feature points observed in n images, the multiple-view
imaging relationship (2) can be equivalently expressed in a
pose-only form






,
1
,
,
i
i
k i
i
n
k
m i
n
g
R







，
t
X
(12)
According to Proposition 2 below, the two-view PPO
constraint (7) can be rewritten as a linear form of relative
translation


,
,
,
,
,
T
T
i j
i j
i j
i j
i j
j
i
R
I




X b
X a
t
(13)
By analogy, the multiple-view DPO constraint (11) can
also be linearly expressed in terms of relative translation
2
2
,
,
,
,
,
,
,
,
,
,
T
T
i
i
i
i
i
i
i
R

















X a
t
t
X b t
(14)
Alternatively, the above expressions can be readily
expressed in terms of global translation. In the sequel,
however, we will present another linear expression of the
global translation.
2.2. Linear global translation constraint
Currently, global rotation initialization algorithms, such as
the rotation averaging algorithm proposed by Chatterjee
and Govindu [13], perform fairly well. The remaining
sub-section
attempts
to
solve
global
translations
preconditioned on known global rotations 
i
i
n
R
.
Left multiply 

i 
X
on both sides of the DPO constraint
(11),






,
,
,
,
,
i
i
i
d
R
i
n i











X
X
t
(15)
According to Proposition 2 below,


,
,
,
,
=
T
d





a
t
(16)
Substituting equation (16) into equation (15), we show that
global
translations
satisfy
the
following
linear
homogeneous equation
0,
,
i
B
C
D
i
n i








t
t
t
(17)
in which






,
,
,
T
i
i
i
i
B
R
R
C
R
D
B
C












X
X a
X
(18)
If


,
i
i
R



X
X
for
,
i
n i



,
then
B
C
D



and equation (17) is always true for any
global translation.
For all 3D feature points, denote by


1 ,
,
T
T
T
n


t
t
t
the
concatenated global translation of n images and rewrite
equation (17) as

L t
(19)
where L  is a matrix comprising global rotations and
normalized image coordinates. It can be proved that

4
rank
n


L
when there are at least two 3D feature
points satisfying
,



(see Proposition 6 below).
Equation (19) is called the linear global translation (LiGT)
constraint. Choose view r as the global translation
reference, namely,
r 
t
(20)
An estimate of global translation ˆt  (
rt  removed) can be
obtained by solving the linear homogeneous equation (19).
There are two ˆt  with opposite signs; however, the right
one can be readily identified by using equation (16), that is,
it should satisfy
,
,
T

a
t
.
Consequently, according to Propositions 3-5 below, the
three representations of multiple-view imaging relationship,
namely (2), (12), and (19), are equivalent. Equation (19)
expresses the multiple-view imaging relationship as a
linear constraint. Given global rotations, the LiGT
constraint (19) enables a linear solution to global
translations, which is proved to be theoretically immune to
camera collinear movement and local pure rotation.
Certainly, the accuracy of the obtained global translations
would be affected by the quality of the given global
rotations. If a higher pose accuracy is required, a proposed
algorithm of pose adjustment (given in Section 3) can be
used to further refine the camera poses. The 3D feature
coordinates can be analytically recovered from the camera
poses.
2.3. Propositions
Proposition 1.




,
,
i j
j i
i
i
d
d

for view pair 

,i j
Proposition 2. The depth can be linearly expressed in terms
of translation, that is,


,
,
,
,
=
T
i j i j
i j
i
i j
d

a t
and


,
,
,
,
T
i j
i j i j
j
i j
d

b t
,
where


,
,
T
T
i j
i j
i
j
j
R










a
X
X
X
and


,
,
,
T
T
i j
i j
i j
i
j
i
R
R










b
X
X
X
.
Proposition 3. The DPO constraint set (11)  the
projection equation (1).
Proposition 4. The LiGT constraint  the depth-equal
constraint.
Proposition 5. The LiGT constraint  the DPO
constraint.
Proposition 6. When there are at least two 3D feature
points
with
different
image
points
such
that
,
,
R









X
X
,

rank
4
n


L
.
For a global pure rotation,
,



for all 3D feature
points and the LiGT constraint can never generate the right
global translation; neither can the projection equation, nor
the DPO constraint. However, as a scenario violating the
Proposition 6 precondition only occurs theoretically,
Proposition 6 actually indicates that the global translation
can almost certainly be solved from the LiGT constraint,
even under special but common movements such as
collinear motion or local pure rotation.
3. Pose adjustment
The gold-standard BA minimizes the reprojection error
formulated by the projection equation (1). Denoting by
iX
the error-contaminated normalized image coordinate of a
3D feature point in the i-th image, the reprojection error is
usually defined as
BA
i
i
i
i
i
T
BA
i






V
X
X
X
e
Y
Y
(21)
where


BA
W
i
i
i
R


Y
X
t
and


0,0,1
T 
e
. For m 3D
feature points observed in n images, a reprojection error
vector
BA
V
can be formed. The error function in the BA
minimization can be expressed as








,
1
1
,
,
,
T
BA
BA
B
W
k
i
i
k i
i
n
k
A
m
k
m i
n
R











，
V
X
V
X
t
(22)
The corresponding BA minimization problem is formulated
as [2, 7]



1
,
,
arg min
W
k
i
i i
n
k
m
R
BA





X
t
(23)
As there are typically a large number of 3D features in a
scene, we can imagine that the equation (23) is a nonlinear
optimization problem in a high-dimensional parameter
space. With the DPO constraint set in equation (11), the
reprojection error for a 3D feature point is given by
PA
i
i
i
i
i
T
PA
i






V
X
X
X
e
Y
Y
(24)
where


,
,
,
i
i
PA
i
d
R








X
t
Y
and


,
d


is computed
using the error-contaminated normalized image coordinate.
For m 3D feature points observed in n images, a
reprojection error vector
PA
V
can be formed. The error
function in the minimization can be expressed as






,
1
,
,
i
i
k i
i
n
k
m i
T
PA
PA
PA
n
R









，
V V
t
X
(25)
The corresponding minimization problem is formulated as

1
,
arg min
i
i i
n
A
R
P


t
(26)
the unknown parameters of which consist of camera poses
only. Therefore, it is referred to as pose adjustment (PA)
throughout the paper.
3.1. Global analytical reconstruction
The 3D multiple-view scene structure can be analytically
reconstructed from the obtained camera poses. For a 3D
feature point, its depth in the left-base view is calculated as


,
,
ˆ
i
i n
i
W
i
z
d









(27)
where
,i


is the weighting coefficient. According to the
two-view case [36],
,i

is a quality indicator of
reconstruction, and thus, we take the weighting coefficient
as
,
,
,
i
i
i
i n
i











. Finally, the 3D feature coordinate is
given by
ˆ
W
W
T
z R






X
t
X
(28)
The world coordinates of m 3D features observed in n
images can be represented entirely by camera poses and
image
points
as








,
1
1
,
,
w
k
i
i
k i
i
n
k
m i
n
k
m
z
R









，
X
t
X
.
3.2. Pose-only algorithm for recovering camera
poses and the 3D scene
Figure 2:  Flow chart of pose-only algorithm
For m 3D feature points and N images (or views). Note
that all feature points are not necessarily observed in each
image here.
Inputs: Global rotations and normalized image coordinates.
Step 1. Designate a view, say view r, as the reference view.
Set the constraint
r 
t
.
Step 2. For the current 3D feature point
W
X
, select
left/right-base views using the following criterion




,
,
,
arg max
i j
i j n





(29)
Step 3. Build the matrix L  using equations (17) and (18).
Step 4. For all 3D feature points, repeat Steps 2-3. Obtain
the global translation ˆt  by solving equation (19).
Step 5. Identify the right global translation solution using
,
,
T

a
t
.
Step 6 (Optional). Implement PA to further improve camera
poses according to equation (26).
Step 7. Analytically reconstruct all 3D feature coordinates
using equations (27) and (28).
The flow chart of the pose-only algorithm is given in Fig.
2.
4. Experiments
The experiment was performed on an Ubuntu 18.04.4
LTS platform, with 128 GB memory and Intel® Xeon(R)
Platinum 8269CY CPU @ 2.50 GHz, one core. The LiGT
algorithm was developed based on Spectra and Eigen C++
libraries, and the PA algorithm was developed using the
SparseLM optimization library.
Two-view relative pose. We utilized the OpenGV library,
which comprises various common two-view processing
algorithms [35, 38-41]
Global rotation. The state-of-the-art libraries of global
structure from motion (SfM), such as OpenMVG and Theia
Vision [42], are mainly based on algorithms proposed by
Chatterjee [19], Hartley [21, 22], and Martinec [43].
Comparably, Chatterjee’s newest algorithm [13] has the
best accuracy and robustness [12, 15] and thus was used to
provide the global rotation of each view.
Global translation. Recovering the global translation is a
key problem in SfM. We compared LUD [15], 1DSfM [12],
and linearSfM [14] in the Theia Vision library. LUD is
found to be robust and outstanding, and thus, it is mainly
shown in real data tests.
Global optimization. BA is the cornerstone of visual
geometry computation. Most state-of-the-art libraries
incorporate the Google Ceres BA [44], although there have
been a number of studies focused on speeding-up BA, such
as sBA [3], ssBA [45], and PBA (or PMBA) [11, 31]. This
study addresses the standard case of the calibrated camera;
therefore, the Google Ceres BA (version 1.14.0) was taken
as the benchmark for algorithm assessment.
King’s-College
(Lund dataset, #20)
Statue-of-Liberty
(Lund dataset, #37)
UWO
(Lund dataset, #40)
Ystad-Monastery
(Lund dataset, #44)
Figure 3: Recovered camera poses and 3D scenes, and reprojection errors of representative data. King’s-College, Statue-of-Liberty, UWO
and Ystad-Monastery are from the Lund dataset. a, Recovered camera poses and 3D scenes by LiGT, LiGT-PA, LUD, and LUD-BA. Red
arrows denote cameras; b, reprojection errors for LiGT-PA and LUD-BA as a function of the number of iterations (maximum set at 100)
performed during the optimization process. The 3D scenes were recovered analytically in LiGT and LiGT-PA, and by traditional
triangulation in LUD. The squares on each vertical axis denote the reprojection errors of LUD and LiGT when global rotations refined by
LiGT-PA are used as the input instead.
4.1. Real test performance
We performed a number of tests on 55 data from the
Lund and OpenSLAM public datasets [46, 47].
Figure 3 presents four representative test results of
King’s College Cambridge, Statue of Liberty, University of
Western Ontario, and Monastery in Ystad from the Lund
dataset. The rotation averaging algorithm [13] has the best
accuracy and robustness [12, 15] and, thus, has been used
LiGT
LiGT-PA
LUD
LUD-BA
b.
a.
to provide global rotations. The LiGT algorithm, as well as
the PA algorithm initialized with the LiGT algorithm
(LiGT-PA),
are
compared
against
state-of-the-art
counterparts: the LUD algorithm [15], to determine global
translations, and the Google Ceres BA algorithm [44]
initialized with the LUD algorithm (LUD-BA). The LiGT
reprojection
error
is
significantly
smaller,
by
approximately two orders of magnitude, than that of LUD.
The results show that the LiGT 3D scene recovery is very
close to that of LUD-BA or LiGT-PA, in contrast to the
LUD result that barely shows the scene outlines. The
LiGT-PA algorithm, within fewer iterations, leads to a
reprojection error that is 1-2 orders of magnitude smaller
than that of LUD-BA. The scene recovery of LUD-BA
appears to be incomplete (e.g., the Statue of Liberty
goddess body and the University of Western Ontario wall
and camera poses). In Fig. 3b, the two squares lying on
each vertical axis denote the reprojection errors of LUD
and LiGT when global rotations refined by LiGT-PA are
used as the input instead. The reprojection errors of LiGT
are further reduced by 1-2 orders of magnitude,

## Approach

The computational costs (in terms of running time and
memory cost) and the reprojection errors across all 55 data
tests are summarized in Fig. 4 clockwise in ascending order
of the number of image points. Compared with LUD-BA,
LiGT-PA reduces, on average, the running time by
approximately 25 times and the memory consumption by
approximately 15 times, whereas LiGT significantly
reduces the running time by approximately 8,000 times on
average (140,000 times maximum) and the memory
consumption by approximately 400 times on average
(5,000 times maximum). It can be well predicted from the
clockwise increasing trend in Fig. 4 that the LiGT’s
computational efficiency advantage will be significantly
more prominent for larger-scale data. Furthermore, in terms
of the final reprojection error, LiGT-PA consistently
outperforms LUD-BA, and notably, the error of LiGT is
even smaller than that of LUD-BA in several tests.
4.2. Further discussions
In summary, the 3D scene quality of the LiGT algorithm
is very close to that of BA and PA. The reprojection error
profile of all algorithms shows that the LiGT algorithm
enables faster convergence and smaller reprojection errors
for optimization in only a few iterations, compared with the
LUD algorithm. Note that the reprojection errors have been
regularized uniformly for all algorithms by way of BA’s
minimization function, using their own estimates of camera
poses and 3D feature coordinates. In fact, it can be well
predicted, according to Propositions 3 and 5, that if the
provided global rotations have high accuracy, the global
translation solution by the LiGT algorithm would be close
to optimality.
LiGT algorithm. It appears that, under such special motions
as small translation or collinear movement, the LiGT
algorithm significantly outperforms the LUD algorithm in
terms of both reprojection error and 3D scene quality.
Notably, the LiGT’s 3D scene can compete in appearance
with those of BA and PA; for instance, in the case of
closed-loop camera motions (#13: Eglise-interior and #38:
The-Pumpkin). For more complex camera motions (#24:
Linkoping-Cathedral), the projection error of the LiGT
algorithm is even smaller than that of LUD-BA, the BA
algorithm initialized by the LUD algorithm.
PA algorithm. LiGT-PA generally outperforms LUD-BA
in terms of both reprojection errors and 3D scene quality.
The LiGT-PA typically requires only a few iterations to
reach convergence, and its final reprojection errors are
smaller than those of LUD-BA (#8: Buddha-temple, #24:
Linkoping-Cathedral, and #38: The-Pumpkin).
Collinear
motion.
Under
collinear
motions
(#8:
Buddha-temple,
#9:
De-Guerre,
and
#36:
Sri-Veeramakaliamman) or local linear motion (#50:
Figure 4: Running time, memory consumption, and final reprojection errors for LiGT, LUD-BA, and LiGT-PA. Arranged clockwise in
ascending order of the number of image points for all 55 data results. a, Time cost in seconds; b, Memory cost in megabytes; c,
Reprojection error.
a.
b.
c.
Malaga), the state-of-the-art LUD algorithm for global
translation is not satisfactory, while the LiGT algorithm
does not appear to be affected and recovers quality 3D
scenes that are very close to those of LUD-BA or
LiGT-PA.
Local small translation. Special cases exist in the Lund
dataset where the camera rotates in a fixed location to take
multiple
photos
(see,
for
example,
#36:
Sri-Veeramakaliamman and #37: Statue-of-Liberty in Fig.
3). These local small translation motions commonly lead to
unsatisfactory results for the LUD algorithm, but they are
handled well by the LiGT algorithm.
Time and memory statistics. The running time excludes
data file reading and writing. The memory cost is calculated
using the Intel VTune Profiler [48].
5. Conclusion
This study presents a pose-only representation for the
multiple-view imaging geometry and discovers that it is
linearly related to camera translation by the LiGT
constraint. The proposed LiGT algorithm not only
produces the global translation efficiently and accurately
but, together with the PA algorithm, can further enhance
the accuracy and robustness (for example, to critical
camera motions) of recovering the camera pose and 3D
scene structure. This work is believed to significantly
reduce
the
efficiency
and
robustness
challenges
encountered in 3D vision computation. In applications
where global rotations can be provided accurately,
nonlinear optimization processes may not be required for
camera poses and the 3D scene structure. Consequently, the
computational cost would be mitigated by several orders of
magnitude, hopefully opening a door to future lightweight
3D visual computation on personal devices or microchips.

## References

[1]
D. Marr and T. Poggio. Cooperative computation of stereo
disparity, Science, vol. 194, no. 4262, pp. 283-287, 1976.
[2]
R. Hartley and A. Zisserman. Multi-View Geometry in
Computer Vision. Cambridge University Press, 2003.
[3]
M. I. A. Lourakis and A. A. Argyros. SBA: a software
package for generic sparse bundle adjustment, ACM
Transactions on Mathematical Software, vol. 36, no. 1, pp.
1-30, 2009.
[4]
T. Schöpsa, T. Sattlera, C. Häne, and M. Pollefeys.
Large-scale outdoor 3D reconstruction on a mobile device,
Computer Vision and Image Understanding, vol. 157, pp.
151-166, 2017.
[5]
N. Snavely, S. M. Seitz, and R. Szeliski. Modeling the
world from internet photo collections, International Journal
of Computer Vision, vol. 80, no. 2, pp. 189-210, 2008.
[6]
S. Agarwal et al. Building Rome in a day, Communications
of the ACM, vol. 54, no. 10, pp. 105-112, 2011.
[7]
Y. Ma, S. Soatto, J. Kosecka, and S. S. Sastry. An Invitation
to 3-D Vision: From Images to Geometric Models. Springer,
2004.
[8]
K. Ni, D. Steedly, and F. Dellaert. Out-of-core bundle
adjustment
for
large-scale
3D
reconstruction,
in
International Conference on Computer Vision, Rio de
Janeiro, 2007, pp. 1-8: IEEE.
[9]
L. Zhang and R. Koch. Structure and motion from line
correspondences: representation, projection, initialization
and sparse bundle adjustment, Journal of Visual
Communication and Image Representation, vol. 25, no. 5,
pp. 904-915, 2014.
[10] R. Zhang, S. Zhu, T. Fang, and L. Quan. Distributed very
large scale bundle adjustment by global camera consensus,
IEEE Transactions on Pattern Analysis and Machine
Intelligence, vol. 42, no. 2, pp. 291-303, 2020.
[11] L. Zhao, S. Huang, Y. Sun, L. Yan, and G. Dissanayake.
ParallaxBA: bundle adjustment using parallax angle feature
parametrization,
International
Journal
of
Robotics
Research, vol. 34, no. 4-5, pp. 493-516, 2015.
[12] K. Wilson and N. Snavely. Robust global translations with
1DSfM, in European Conference on Computer Vision,
Zurich, Switzerland, 2014, pp. 61-75: Springer.
[13] A. Chatterjee and V. M. Govindu. Robust relative rotation
averaging, IEEE Transactions on Pattern Analysis and
Machine Intelligence, vol. 40, no. 4, pp. 958-972, 2017.
[14] N. Jiang, Z. Cui, and P. Tan. A global linear method for
camera pose registration, in IEEE International Conference
on Computer Vision, Sydney, NSW, 2013, pp. 481-488.
[15] O. Ozyesil and A. Singer. Robust camera location
estimation by convex programming, in IEEE Conference on
Computer Vision and Pattern Recognition, Boston, MA,
2015, pp. 2674-2683: IEEE.
[16] B. Triggs, P. F. McLauchlan, R. I. Hartley, and A. W.
Fitzgibbon. Bundle adjustment — a modern synthesis, in
International Workshop on Vision Algorithms, 1999, pp.
298-372: Springer.
[17] M. Lhuillier and L. Quan. A quasi-dense approach to
surface reconstruction from uncalibrated images, IEEE
Transactions on Pattern Analysis and Machine Intelligence,
vol. 27, no. 3, pp. 418-433, 2005.
[18] F. Arrigoni, L. Magri, B. Rossi, P. Fragneto, and A. Fusiello.
Robust Absolute Rotation Estimation via Low-Rank and
Sparse Matrix Decomposition, in International Conference
on 3D Vision, Tokyo, 2014, pp. 491-498.
[19] A. Chatterjee and V. Madhav Govindu. Efficient and robust
large-scale rotation averaging, in IEEE International
Conference on Computer Vision, Sydney, NSW, Australia,
2013, pp. 521-528: IEEE.
[20] V. M. Govindu. Combining two-view constraints for
motion estimation, in IEEE Conference on Computer Vision
and Pattern Recognition, Kauai, HI, USA, 2001, vol. 2:
IEEE.
[21] R. Hartley, K. Aftab, and J. Trumpf. L1 rotation averaging
using the Weiszfeld algorithm, in IEEE Conference on
Computer Vision and Pattern Recognition, Providence, RI,
USA, 2011, pp. 3041-3048: IEEE.
[22] R. Hartley, J. Trumpf, Y. Dai, and H. Li. Rotation averaging,
International Journal of Computer Vision, vol. 103, no. 3,
pp. 267-305, 2013.
[23] J. Fredriksson and C. Olsson. Simultaneous Multiple
Rotation Averaging Using Lagrangian Duality, in Asian
Conference on Computer Vision, Daejeon, Korea, 2012, pp.
245-258: Springer.
[24] V. M. Govindu. Lie-algebraic averaging for globally
consistent motion estimation, in IEEE Conference on
Computer Vision and Pattern Recognition, Washington, DC,
USA, 2004: IEEE.
[25] B. Zhuang, L.-F. Cheong, and G. Hee Lee. Baseline
desensitizing in translation averaging, in IEEE Conference
on Computer Vision and Pattern Recognition, Salt Lake
City, UT, 2018, pp. 4539-4547.
[26] T. Goldstein, P. Hand, C. Lee, V. Voroninski, and S. Soatto.
ShapeFit and ShapeKick for Robust, Scalable Structure
from Motion, in European Conference on Computer Vision,
Amsterdam, 2016, pp. 289-304: Springer.
[27] P. Moulon, P. Monasse, and R. Marlet. Global fusion of
relative motions for robust, accurate and scalable structure
from motion, in IEEE International Conference on
Computer Vision, Sydney, NSW, 2013, pp. 3248-3255:
IEEE.
[28] K. Sim and R. Hartley. Recovering camera motion using L
∞ minimization, in IEEE Conference on Computer Vision
and Pattern Recognition, New York, NY, USA, 2006, pp.
1230-1237: IEEE.
[29] O. Ozyesil, A. Singer, and R. Basri. Stable Camera Motion
Estimation Using Convex Programming, SIAM Journal on
Imaging Sciences, pp. 1220-1262, 2015.
[30] Z. Cui, N. Jiang, C. Tang, and P. Tan. Linear Global
Translation Estimation with Feature Tracks, in Proceedings
of the British Machine Vision Conference (BMVC),
SWANSEA, UK, 2015, pp. 46.1-46.13: BMVA Press.
[31] L. Liu, T. Zhang, B. Leighton, L. Zhao, S. Huang, and G.
Dissanayake. Robust global structure from motion pipeline
with parallax on manifold bundle adjustment and
initialization, IEEE Robotics Automation Letters, vol. 4, no.
2, pp. 2164-2171, 2019.
[32] S. Agarwal, N. Snavely, S. M. Seitz, and R. Szeliski. Bundle
adjustment in the large, in European Conference on
Computer Vision, Berlin, Heidelberg, 2010, pp. 29-42:
Springer Berlin Heidelberg.
[33] M. Byröd and K. Åström. Conjugate gradient bundle
adjustment, in European Conference on Computer Vision,
Heraklion, Crete, Greece, 2010, pp. 114-127: Springer.
[34] L. Liu, T. Zhang, B. Leighton, L. Zhao, S. Huang, and G.
Dissanayake. Robust Global Structure From Motion
Pipeline With Parallax on Manifold Bundle Adjustment and
Initialization, IEEE Robotics and Automation Letters, vol. 4,
pp. 2164-2171, 2019.
[35] H. C. Longuet-Higgins. A computer algorithm for
reconstructing a scene from two projections, Nature, vol.
293, no. 5828, pp. 133-135, 1981/09/01 1981.
[36] Q. Cai, Y. Wu, L. Zhang, and P. Zhang. Equivalent
constraints for two-view geometry: pose solution/pure
rotation identification and 3D reconstruction, International
Journal of Computer Vision, vol. 127, no. 2, pp. 163-180,
2019.
[37] S. Agarwal, A. Pryhuber, R. Sinn, and R. R. Thomas,
"Multiview
Chirality,"
https://arxiv.org/abs/2003.09265v12020.
[38] D. Nister. An efficient solution to the five-point relative
pose problem, in IEEE Conference on Computer Vision and
Pattern Recognition, 2003, vol. 2, pp. II-195: IEEE.
[39] H. Stewenius, C. Engels, and D. Nistér. Recent
developments on direct relative orientation, ISPRS Journal
of Photogrammetry, vol. 60, no. 4, pp. 284-294, 2006.
[40] L. Kneip, R. Siegwart, and M. Pollefeys. Finding the exact
rotation between two images independently of the
translation, in European Conference on Computer Vision,
2012, pp. 696-709: Springer.
[41] L. Kneip and P. Furgale. OpenGV: a unified and
generalized approach to real-time calibrated geometric
vision, in IEEE International Conference on Robotics and
Automation (ICRA), 2014, pp. 1-8: IEEE.
[42] C. Sweeney. (2018). Theia Vision Library. Available:
http://theia-sfm.org/
[43] D. Martinec and T. Pajdla. Robust rotation and translation
estimation in multiview reconstruction, in IEEE Conference
on Computer Vision and Pattern Recognition, Minneapolis,
MN, 2007, pp. 1-8: IEEE.
[44] S. Agarwal and K. Mierle. (2018, 2019). Ceres Solver.
Available: http://ceres-solver.org
[45] K. Konolige and W. Garage. Sparse sparse bundle
adjustment, in British Machine Vision Conference,
Aberystwyth, UK, 2010, vol. 10, pp. 102.1-102.11: BMVA
Press.
[46] O. Enqvist, F. Kahl, and C. Olsson. (2011). LUND dataset.
Available:
http://www.maths.lth.se/matematiklth/personal/calle/datase
t/dataset.html
[47] L. Zhao, S. Huang, Y. Sun, and G. Dissanayake. (2013).
OpenSLAM-ParallaxBA
dataset.
Available:
https://github.com/OpenSLAM-org/openslam_ParallaxBA
[48] (2020).
Intel
VTune
Profiler.
Available:
https://software.intel.com/content/www/us/en/develop/tool
s/vtune-profiler.html
Q. CAI ET AL.:  EQUIVALENT CONSTRAINTS FOR TWO-VIEW GEOMETRY

SUPPLEMENTARY INFORMATION
3
A Pose-only Solution to Visual Reconstruction and Navigation
5
Qi Cai1#, Lilian Zhang2#, Yuanxin Wu1#*, Wenxian Yu1, Dewen Hu2*
8
1 Shanghai Key Laboratory of Navigation and Location-based Services, School of Electronic Information and Elec10
trical Engineering, Shanghai Jiao Tong University, China.
2 College of Intelligent Science and Technology, National University of Defense Technology, China.
#These authors contributed equally to this work.
*Corresponding authors (yuanxin.wu@sjtu.edu.cn; dwhu@nudt.edu.cn).
15
Q. CAI ET AL.:  EQUIVALENT CONSTRAINTS FOR TWO-VIEW GEOMETRY

Contents
2
Fig. 1 | Representative results of the Lund/OpenSLAM datasets. ............................................................................... 3
Fig. 2 | Other results of the Lund dataset. .................................................................................................................... 5
Fig. 3 | Other results of the OpenSLAM dataset. ....................................................................................................... 10
Table 1 | Time Cost .................................................................................................................................................... 12
Table 2 | Reprojection Error ....................................................................................................................................... 14
Table 3 | Scattering Degree of Reconstructed 3D Points ........................................................................................... 16
Fig. 4 | Representative results of the 1DSfM dataset. ................................................................................................ 19
Fig. 5 | Notre Dame result before and after parameter tuning. .................................................................................. 21
Fig. 6 | Ellis Island result before and after parameter tuning. .................................................................................... 22
Table 4 | Number of Estimated Views and Tracks By Theia and Pose-only Solution ............................................... 23
13
Q. CAI ET AL.:  EQUIVALENT CONSTRAINTS FOR TWO-VIEW GEOMETRY

FIG. 1 | REPRESENTATIVE RESULTS OF THE LUND/OPENSLAM DATASETS.
#6: Basilica-di-SMF (Lund)
LUD
LUD-BA
LiGT
LiGT-PA
#8: Buddha-temple (Lund)
#9: De-Guerre (Lund)
#13: Eglise-interior (Lund)
#24: Linkoping-Cathedral (Lund)
#36: Sri-Veeramakaliamman (Lund)
#38: The-Pumpkin (Lund)
#50: Malaga (OpenSLAM)
Q. CAI ET AL.:  EQUIVALENT CONSTRAINTS FOR TWO-VIEW GEOMETRY

The charts in the first column show the reprojection errors for LiGT-PA and LUD-BA as a function of
the number of iterations performed during the optimisation process. Charts in the remaining four col2
umns show the recovered 3D scenes by LUD, LUD-BA, LiGT, and LiGT-PA, respectively. The 3D
scenes were recovered analytically in LiGT and LiGT-PA, and by traditional triangulation in LUD.
The LiGT algorithm enables faster convergence and smaller reprojection errors for PA, and is very
close to BA and PA in 3D scene quality. Note that there are collinear motions in #8: Buddha-temple,
#9: De-Guerre, and #36: Sri-Veeramakaliamman, local linear motion in #50: Malaga, and local small
translation in #36: Sri-Veeramakaliamman.
9
Q. CAI ET AL.:  EQUIVALENT CONSTRAINTS FOR TWO-VIEW GEOMETRY

FIG. 2 | OTHER RESULTS OF THE LUND DATASET.
#1: West-Side-gardens
LUD
LUD-BA
LiGT
LiGT-PA
#2: Alcatraz-courtyard
#3: Alcatraz-water-tower
#4: Barcelona
#5: Basilica-di-San-Petronio
#7: Buddha
#10: Doge’s-Palace
#11: Door
Q. CAI ET AL.:  EQUIVALENT CONSTRAINTS FOR TWO-VIEW GEOMETRY

#12: Eglise
LUD
LUD-BA
LiGT
LiGT-PA
#14: Filbyter
#15: Fine-Arts
#16: Fort-Channing-gate
#17: Golden-statue
#18: Goteborg
#19: GustavIIAdolf
#21: Kronan
Q. CAI ET AL.:  EQUIVALENT CONSTRAINTS FOR TWO-VIEW GEOMETRY

#22: Lejonet
LUD
LUD-BA
LiGT
LiGT-PA
#23: LUsphinx
#25: Lund-Cathedral
#26: Nijo
#27: Nikolai
#28: Orebro
#29: Park-gate
#30: Plaza-de-Armas
Q. CAI ET AL.:  EQUIVALENT CONSTRAINTS FOR TWO-VIEW GEOMETRY

#31: Porta-San-Donato
LUD
LUD-BA
LiGT
LiGT-PA
#32: Round church
#33: Smolny
#34: Sri_Mariamman
#35: Sri-Thendayuthapani
#39: Thian-Hook-Keng-temples
#41: University-of-Toronto
#42: UrbanII
Q. CAI ET AL.:  EQUIVALENT CONSTRAINTS FOR TWO-VIEW GEOMETRY

#43: Vasa
LUD
LUD-BA
LiGT
LiGT-PA
#45: Yueh_Hai_Ching_Temple
The charts in the first column show the reprojection errors for LiGT-PA and LUD-BA as a function of
the number of iterations performed during the optimisation process. Charts in the remaining four col3
umns show the recovered 3D scenes by LUD, LUD-BA, LiGT, and LiGT-PA, respectively. The 3D
scenes were recovered analytically in LiGT and LiGT-PA, and by traditional triangulation in LUD.
6
Q. CAI ET AL.:  EQUIVALENT CONSTRAINTS FOR TWO-VIEW GEOMETRY

FIG. 3 | OTHER RESULTS OF THE OPENSLAM DATASET.
#46: College
LUD
LUD-BA
LiGT
LiGT-PA
#47: Dunhuan
#48: Fake-pile
#49: Jinan
#51: Toronto
#52: Usyd_main_quad
#53: Vaihingen
#54: Victoria_cottage
Q. CAI ET AL.:  EQUIVALENT CONSTRAINTS FOR TWO-VIEW GEOMETRY

#55: Village
LUD
LUD-BA
LiGT
LiGT-PA
2
The charts in the first column show the reprojection errors for LiGT-PA and LUD-BA as a function of
the number of iterations performed during the optimisation process. Charts in the remaining four col4
umns show the recovered 3D scenes by LUD, LUD-BA, LiGT, and LiGT-PA, respectively. The 3D
scenes were recovered analytically in LiGT and LiGT-PA, and by traditional triangulation in LUD.
Q. CAI ET AL.:  EQUIVALENT CONSTRAINTS FOR TWO-VIEW GEOMETRY

TABLE 1 | TIME COST
#
data
(Lund)
cams
pts
obs
time
(LiGT)
time
(LiGTPA)
iteration
(LiGTPA)
time
(LUD-BA)
iteration
(LUD-BA)
time ratio
(LiGTPA/LiGT)
time ratio
(LUDBA/LiGT)
Alcatraz-West-Side-gardens
65072
0.418
86.285
234.287
206.5
560.8
Alcatraz-courtyard
23674
0.046
3.880
83.217
84.1
1803.1
Alcatraz-water-tower
14828
0.065
1.314
47.975
20.3
742.5
Barcelona
30367
0.058
3.281
134.467
57.0
2334.5
Basilica-di-San-Petronio
46035
0.218
16.597
238.457
76.3
1096.4
Basilica-di-SMF
564904
4.944
608.280
2445.910
123.0
494.7
Buddha
156356
0.113
134.123
483.883
1184.9
4275.0
Buddha-temple
27920
0.050
2.206
91.387
44.1
1828.8
De-Guerre
13477
0.003
0.465
3.245
145.8
1016.6
Doge’s-Palace
67107
0.122
7.332
374.276
60.2
3070.6
Door
17650
0.000
0.434
2.516
986.6
5723.6
Eglise
84792
0.024
2.119
192.993
87.6
7972.9
Eglise-interior
29314
0.339
4.814
190.215
14.2
561.3
Filbyter
21150
0.002
0.915
16.131
471.1
8305.3
Fine-Arts
30723
0.221
3.560
18.614
16.1
84.2
Fort-Channing-gate
23627
0.002
0.590
2.915
367.7
1816.2
Golden-statue
39989
0.001
0.540
3.721
521.1
3591.9
Goteborg
25655
0.059
21.786
99.479
368.0
1680.3
GustavIIAdolf
5813
0.004
0.724
0.818
176.1
198.9
King’s-College
238449
0.197
104.843
1343.690
533.2
6833.2
Kronan
28371
0.048
2.358
142.600
49.0
2964.5
Lejonet
74423
0.180
7.405
290.651
41.1
1612.4
LUsphinx
32668
0.008
0.850
6.016
103.1
730.2
Linkoping-Cathedral
202737
0.227
12.291
686.701
54.2
3026.3
Lund-Cathedral
159055
5.021
40.305
1540.220
8.0
306.7
Nijo
7348
0.001
0.224
0.833
216.1
804.3
Nikolai
37857
0.015
1.580
6.467
108.8
445.6
Orebro
53857
1.455
11.391
51.795
7.8
35.6
Park-gate
9099
0.003
0.383
1.423
140.8
523.6
Plaza-de-Armas
26969
0.143
5.365
215.965
37.6
1513.7
Porta-San-Donato
25490
0.049
7.032
79.139
142.8
1606.7
Round-church
84643
0.029
2.213
141.120
76.2
4856.0
Smolny
51115
0.039
3.093
24.593
79.2
629.7
Sri-Mariamman
56220
0.078
4.223
140.022
54.3
1799.8
Sri-Thendayuthapani
88849
0.026
5.050
31.216
191.7
1184.6
Sri-Veeramakaliamman
130013
0.052
8.806
227.872
170.2
4404.9
Q. CAI ET AL.:  EQUIVALENT CONSTRAINTS FOR TWO-VIEW GEOMETRY

(cams: cameras; pts: 3D points; obs: image point observations.)
2
Table 1 lists the running time (in seconds) of LiGT, LiGT-PA, and LUD-BA, respectively, and the iteration times
of LiGT-PA and LUD-BA in the Lund and OpenSLAM tests. The running time ratios of LiGT-PA and LUD-BA with
respect to LiGT are calculated in the two right-most columns and are plotted in Fig. 2.
6
Statue-of-Liberty
49248
0.016
46.854
68.954
2877.5
4234.7
The-Pumpkin
69341
0.065
3.706
98.843
57.1
1523.2
Thian-Hook-Keng-temple
34288
0.031
2.053
70.475
65.5
2248.9
UWO
97326
0.998
11.158
761.110
11.2
762.7
University-of-Toronto
7087
0.006
0.841
5.073
143.9
867.8
UrbanII
22284
0.013
1.138
4.258
89.4
334.4
Vasa
4249
0.001
0.452
0.689
483.4
736.8
Ystad-Monestary
139951
0.122
7.916
570.254
64.9
4673.1
Yueh-Hai-Ching-Temple
13774
0.004
0.426
20.339
97.5
4653.9
#
data
(OpenSLAM)
cams
pts
obs
time
(LiGT)
time
(LiGTPA)
iteration
(LiGTPA)
time
(LUD-BA)
iteration
(LUD-BA)
time ratio
(LiGTPA/LiGT)
time ratio
(LUDBA/LiGT)
College
1236502
0.070
42.023
978.974
599.9
13975.4
DunHuan
250782
0.004
2.425
29.736
599.4
7348.4
Fake-pile
11318
0.002
0.587
23.323
247.9
9846.2
Jinan
1228959
0.005
22.444
764.939
4390.8
149647.7
Malaga
58404
0.014
79.590
97.678
5869.9
7204.0
Toronto
113685
0.001
0.409
95.316
536.3
125115.5
Usyd-main-quad
227615
0.210
28.654
479.589
136.7
2287.9
Vaihingen
554169
0.001
1.584
31.824
1425.7
28633.9
Victoria-cottage
153632
0.102
205.554
393.529
2023.6
3874.1
Village
1849740
0.007
14.391
130.252
2114.4
19137.3
Q. CAI ET AL.:  EQUIVALENT CONSTRAINTS FOR TWO-VIEW GEOMETRY

TABLE 2 | REPROJECTION ERROR
#
Data (Lund)
cams
pts
obs
initial reprojection error
end reprojection error
LiGT-BA&PA
LUD-BA&PA
LiGT-BA
LUD-BA
LiGT-PA
LUD-PA
Alcatraz-West-Side-gardens
65072
2.478
162.351
0.103
3.180
0.134
0.127
Alcatraz-courtyard
23674
0.379
6.032
0.035
0.033
0.044
0.044
Alcatraz-water-tower
14828
0.147
4.539
0.012
0.225
0.016
0.016
Barcelona
30367
0.579
118.330
0.047
0.388
0.060
0.060
Basilica-di-San-Petronio
46035
3.382
20.403
0.156
0.173
1.130
0.198
Basilica-di-SMF
564904
15.214
6844.949
0.789
11.563
0.911
0.857
Buddha
156356
46.615
188.014
0.408
6.306
3.701
2.505
Buddha-temple
27920
0.209
46.621
0.024
0.454
0.031
0.031
De-Guerre
13477
0.007
8.086
0.003
0.003
0.004
0.004
Doge’s-Palace
67107
1.191
111.959
0.112
2.518
0.129
0.263
Door
17650
0.004
1.081
0.002
0.002
0.003
0.003
Eglise
84792
0.259
27.713
0.011
0.028
0.016
0.016
Eglise-interior
29314
0.541
39.318
0.070
0.450
0.080
0.081
Filbyter
21150
0.025
1.498
0.001
0.012
0.002
0.002
Fine-Arts
30723
0.353
1.636
0.084
0.084
0.104
0.105
Fort-Channing-gate
23627
0.008
0.209
0.002
0.002
0.003
0.003
Golden-statue
39989
0.007
0.349
0.002
0.002
0.003
0.003
Goteborg
25655
0.329
18.969
0.041
0.077
0.050
0.051
GustavIIAdolf
5813
0.002
0.159
0.001
0.001
0.001
0.001
King’s-College
238449
13.880
2493.362
0.396
18.496
0.343
94.881
Kronan
28371
0.194
72.943
0.031
0.293
0.037
0.037
Lejonet
74423
3.582
270.539
0.110
2.467
0.132
3.316
LUsphinx
32668
0.015
0.923
0.005
0.005
0.007
0.007
Linkoping-Cathedral
202737
1.547
232.937
0.125
2.051
0.147
0.197
Lund-Cathedral
159055
4.586
3294.693
0.311
97.377
0.399
67131.299
Nijo
7348
0.003
0.095
0.001
0.001
0.001
0.001
Nikolai
37857
0.027
1.000
0.008
0.008
0.011
0.011
Orebro
53857
2.458
53.101
0.128
0.128
0.157
0.157
Park-gate
9099
0.004
0.038
0.001
0.001
0.002
0.002
Plaza-de-Armas
26969
2.828
20.451
0.103
0.144
0.126
0.126
Porta-San-Donato
25490
1.220
70.170
0.031
0.229
0.049
0.039
Round-church
84643
0.402
10.276
0.019
0.145
0.026
0.026
Smolny
51115
0.780
2.819
0.084
0.084
0.098
0.098
Sri-Mariamman
56220
0.455
94.694
0.056
0.657
0.070
0.070
Sri-Thendayuthapani
88849
1.916
16.567
0.081
0.081
0.118
0.119
Sri-Veeramakaliamman
130013
11.596
201.514
0.154
1.227
0.127
0.255
Statue-of-Liberty
49248
1.393
172.478
0.014
0.747
0.017
0.035
The-Pumpkin
69341
0.128
92.353
0.020
0.661
0.025
0.025
Q. CAI ET AL.:  EQUIVALENT CONSTRAINTS FOR TWO-VIEW GEOMETRY

Thian-Hook-Keng-temple
34288
2.936
35.184
0.129
0.758
0.050
0.493
UWO
97326
3.058
819.236
0.132
28.172
0.158
3.152
University-of-Toronto
7087
0.006
0.566
0.001
0.007
0.001
0.001
UrbanII
22284
0.149
1.569
0.005
0.005
0.007
0.007
Vasa
4249
0.009
0.360
0.001
0.001
0.001
0.001
Ystad-Monastery
139951
1.951
474.913
0.162
1.704
0.191
0.190
Yueh-Hai-Ching-Temple
13774
0.160
1.802
0.010
0.019
0.007
0.007
#
data
(OpenSLAM)
cams
pts
obs
initial reprojection error
end reprojection error
LiGT-BA&PA
LUD-BA&PA
LiGT-BA
LUD-BA
LiGT-PA
LUD-PA
College
1236502
0.531
33.728
0.079
0.246
0.138
0.138
DunHuan
250782
0.013
48.234
0.003
0.003
0.005
0.005
Fake-pile
11318
0.002
13.747
0.001
0.492
0.001
0.010
Jinan
1228959
0.005
49.547
0.002
0.002
0.003
0.003
Malaga
58404
0.229
10.404
0.027
0.606
0.150
0.227
Toronto
113685
0.001
290.775
0.000
0.232
0.001
0.000
Usyd-main-quad
227615
107.747
879.497
2.485
15.537
3.206
3.217
Vaihingen
554169
0.001
1.133
0.001
0.001
0.001
0.001
Victoria-cottage
153632
19.258
170.191
1.273
12.691
1.621
1.626
Village
1849740
0.005
0.377
0.002
0.002
0.003
0.003
Table 2 lists the initial and the final reprojection errors of four optimisation algorithms: LUD-BA, LUD-PA, LiGT2
BA, and LiGT-PA. Note that their initial reprojection errors are exactly those of the corresponding initialisation al3
gorithms. The reprojection errors have been regularised uniformly, for all algorithms, by way of BA’s minimisation
function, using their own estimates of camera poses and 3D feature coordinates. The reprojection errors are partly
plotted in Fig. 2. In fact, we tested and found that all algorithms of LUD, 1DSfM, LinearSfM, and OpenMVG are
generally consistent under normal scenarios, but LUD performs the best under abnormal scenarios. Therefore, only
LUD is compared with LiGT here. The reprojection error columns are given colour backgrounds for clear comparison
and, in the same colour region, the bold-faced numbers indicate that the reprojection errors brought about by LiGT
and LUD are different by over one order of magnitude.

The reprojection error of LiGT is over one order of magnitude smaller than that of LUD in most test data, and
even better than those of LUD-BA/PA in #20: King’s-College, #25: Lund-Cathedral, and #48: Fake-pile.

For all test data, the reprojection errors of LiGT-BA/PA are consistently superior to those of LUD-BA/PA.
14
Q. CAI ET AL.:  EQUIVALENT CONSTRAINTS FOR TWO-VIEW GEOMETRY

TABLE 3 | SCATTERING DEGREE OF RECONSTRUCTED 3D POINTS
#
Data (Lund)
LiGT
LiGT-BA
LiGT-PA
LUD
LUD-BA
LUD-PA
Alcatraz-West-Side-gardens
0.430
3.391
0.335
1.998
96.705
0.530
Alcatraz-courtyard
0.242
4.780
0.179
0.494
1.238
0.172
Alcatraz-water-tower
0.343
0.547
0.272
0.737
104.230
0.272
Barcelona
0.082
0.063
0.063
0.244
22.787
0.063
Basilica-di-San-Petronio
0.182
3.085
0.127
0.436
6.590
0.127
Basilica-di-SMF
1.084
4.641
14.976
99.594
36.779
18.901
Buddha
0.001
0.460
0.001
0.003
6.882
0.001
Buddha-temple
0.210
0.165
0.166
0.626
136.659
0.166
De-Guerre
0.058
0.055
0.055
0.209
0.055
0.055
Doge’s-Palace
0.428
2.275
0.337
4.448
4018.160
1.189
Door
0.030
0.030
0.030
0.072
0.030
0.030
Eglise
0.124
0.078
0.078
0.342
1.904
0.078
Eglise-interior
0.704
0.558
0.556
1.997
62.421
0.556
Filbyter
0.221
0.160
0.160
2.359
31.924
0.160
Fine-arts
0.369
0.283
0.285
0.526
0.283
0.285
Fort-Channing-gate
0.020
0.018
0.018
0.042
0.018
0.018
Golden-statue
0.057
0.044
0.044
0.110
0.044
0.044
Goteborg
0.124
0.096
0.096
0.342
13.864
0.096
GustavIIAdolf
0.037
0.036
0.036
0.059
0.036
0.036
King’s-College
0.132
4.272
0.084
5.292
339.921
0.203
Kronan
0.215
0.179
0.181
0.790
118.725
0.181
Lejonet
0.120
0.082
0.083
0.341
32.606
0.095
LUsphinx
0.066
0.058
0.058
0.116
0.058
0.058
Linkoping-Cathedral
0.037
0.027
0.027
0.111
8.586
0.027
Lund-Cathedral
0.048
0.034
0.034
0.163
15.314
0.055
Nijo
0.073
0.066
0.066
0.124
0.066
0.066
Nikolai
0.038
0.035
0.035
0.072
0.035
0.035
Orebro
0.210
0.171
0.171
0.396
0.171
0.171
Park-gate
0.050
0.048
0.048
0.069
0.048
0.048
Plaza-de-Armas
0.189
1.752
0.116
0.361
15.202
0.116
Porta-San-Donato
0.102
0.059
0.059
0.205
5.844
0.059
Round-church
0.047
0.029
0.029
0.147
10.633
0.029
Smolny
0.240
0.179
0.180
0.338
0.179
0.180
Sri-Mariamman
0.152
0.116
0.118
0.399
111.891
0.118
Sri-Thendayuthapani
0.441
0.348
0.355
0.776
0.348
0.355
Sri-Veeramakaliamman
0.364
2.162
0.238
0.879
39.661
0.249
Statue-of-Liberty
0.032
0.408
0.020
0.078
21.858
0.021
The-Pumpkin
0.012
0.009
0.010
0.048
14.942
0.010
Thian-Hook-Keng-temple
0.161
16.660
0.089
0.439
561.589
0.102
UWO
0.201
0.143
0.144
8.108
244.222
0.207
University-of-Toronto
0.138
0.112
0.110
0.415
0.172
0.110
UrbanII
0.107
0.087
0.088
0.140
0.087
0.088
Vasa
0.047
0.041
0.041
0.097
0.041
0.041
Ystad-Monestary
0.209
0.139
0.145
0.813
60.364
0.145
Yueh-Hai-Ching-Temple
0.241
2.758
0.187
0.419
10.771
0.187
Table 3 lists the 3D point-scattering phenomenon for the Lund dataset, quantified by the average distance (unit:
meter) of each recovered 3D feature point from its nearest neighbour. This table is plotted in Fig. 4, clockwise, in
Q. CAI ET AL.:  EQUIVALENT CONSTRAINTS FOR TWO-VIEW GEOMETRY

ascending order of the number of image points.
2
Q. CAI ET AL.:  EQUIVALENT CONSTRAINTS FOR TWO-VIEW GEOMETRY

Test Results of 1DSfM Dataset
2
Figure 4 presents the reconstruction result of seven data and Table 4 summarizes the number of reconstructed views
and tracks. Both Theia and the pose-only solution use their default parameters throughout the tests, if not explicitly
stated. Their successful rates of Theia and are 3/7 (algorithm crashed in four data) and 6/7 (poor result in one data,
Ellis Island), respectively. Specifically, they are both successful in Montreal Notre Dame and Notre Dame with com6
parable reconstruction quality. Note that the reprojection errors do not completely accord with the quality of recon7
struction is very likely due to the remaining outliers. It should be noted that LiGT-BA performs not well in Fig. 4, as
the outlier-handling pipeline of the pose-only solution keeps a large number of point observations of small
,


(as
shown in Table 4, the reconstructed track number by the pose-only solution is about two times that by Theia), which
is problematic to the bundle adjustment taking 3D feature coordinates as optimizing parameters. While those point
observations of small
,


are removed, the LiGT-BA performance is significantly improved, and LiGT and LiGT12
PA are less affected, as shown in Fig. 5 with Notre Dame. In contrast, the final BA of Theia performs quite well
because the point observations of small
,


are removed as well in its outlier-handling pipeline.
For all data that the pose-only solution is successful, LiGT is very close to the optimization algorithms in reconstruc15
tion quality. The reason that LiGT-BA performs unsatisfactorily throughout the test is owed to the same above-men16
tioned reason.
Regarding the data of Ellis Island, the pose-only solution performs not well by the default parameter, but can be
improved when those 3D points with track length smaller than 3 are removed, as shown in Fig. 6.
20
22
24
Q. CAI ET AL.:  EQUIVALENT CONSTRAINTS FOR TWO-VIEW GEOMETRY

FIG. 4 | REPRESENTATIVE RESULTS OF THE 1DSFM DATASET.
Data
Opt. Iteration
LiGT
LiGT-PA
LiGT-BA
Theia
Montreal Notre Dame
Notre Dame
Alamo
-
NYC Library
-
Piazza del Popolo
-
Tower of London
-
Ellis Island
Q. CAI ET AL.:  EQUIVALENT CONSTRAINTS FOR TWO-VIEW GEOMETRY

Both Theia and the pose-only solution use their default parameters throughout the tests. Their success1
ful rates of Theia and are 3/7 (algorithm crashed in four data) and 6/7 (poor result in one data, Ellis
Island), respectively. The reprojection errors are calculated by BA and PA, respectively.
4
Q. CAI ET AL.:  EQUIVALENT CONSTRAINTS FOR TWO-VIEW GEOMETRY

FIG. 5 | NOTRE DAME RESULT BEFORE AND AFTER PARAMETER TUNING.
Data
Opt. Iteration
LiGT
LiGT-PA
LiGT-BA
Theia
Notre Dame
*Notre Dame
When those point observations of small
,


are removed, the LiGT-BA performance is significantly
improved, and LiGT and LiGT-PA are less affected.
5
7
9
Q. CAI ET AL.:  EQUIVALENT CONSTRAINTS FOR TWO-VIEW GEOMETRY

FIG. 6 | ELLIS ISLAND RESULT BEFORE AND AFTER PARAMETER TUNING.
Data
Opt. Iteration
LiGT
LiGT-PA
LiGT-BA
Theia
Ellis Island
*Ellis Island
By removing 3D feature points of tracking length smaller than 3, the Ellis Island result of the pose3
only solution is improved.
5
7
Q. CAI ET AL.:  EQUIVALENT CONSTRAINTS FOR TWO-VIEW GEOMETRY

TABLE 4 | NUMBER OF ESTIMATED VIEWS AND TRACKS BY THEIA AND POSE-ONLY SOLUTION
Data

## Method

# Estimated
views
# Input
views
# Estimated
tracks
# Input
tracks
Montreal Notre Dame
Theia
474
337088
Pose-only
275223
Notre Dame
Theia
553
587692
Pose-only
519423
*Notre Dame
Pose-only
218241
Alamo
Theia
318946
Pose-only
287774
NYC Library
Theia
180176
Pose-only
151783
Piazza del Popolo
Theia
98253
Pose-only
81370
Tower of London
Theia
295360
Pose-only
267961
Ellis Island
Theia
247
108795
Pose-only
78189
*Ellis Island
Pose-only
13591
*parameter-tuned tests
3
