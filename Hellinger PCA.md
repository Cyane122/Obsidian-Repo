# 핵심 정보
- 생태학 및 생물다양성 연구에서 흔히 사용되는 다변량 통계 기법.
- Hellinger 변환(Hellinger transformation)을 적용한 후 [[Principal Component Analysis|주성분분석]](PCA, Principal Component Analysis)을 수행하는 방법.
- 종 풍부도나 출현 데이터와 같이 희소하고 비정규적인 생태 자료를 다루는 데 적합함.

# 작동 원리
- 생태 데이터는 많은 종이 0 또는 낮은 빈도로 관찰된다. 이러한 데이터에 일반적인 PCA를 적용하면 왜곡이 발생하므로, Hellinger 변환(각 항복의 상대적 풍부도의 제곱근)을 취해 데이터의 유클리드 거리가 Hellinger distance에 근사하도록 조정
	$y_{ij} = \sqrt{x_{ij}/\sum_j x_{ij}}$
	- $x_{ij}$: $i$번째 샘플의 $j$번째 종의 풍부도