# 정의
여러 개의 [[Self-Attention]]을 병렬로 수행하는 구조.

# 구조
$\mathrm{head}_i = \mathrm{attention}(QW^Q_i, KW^K_i, VW^V_i)$
$\mathrm{MultiHead} = \mathrm{Concat}(\mathrm{head}_1, \cdot, \mathrm{head}_h)W^O$

# 역할
- 서로 다른 representation subspace 학습
- 다양한 관계 포착 -> 표현력 증가!