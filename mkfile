<mk_concatVCF.mk

CONCATVCF_PREREQ = `{./prereq}

results/concatVCF/$CONCATVCF_NAME.vcf.gz:D:	$CONCATVCF_PREREQ
	mkdir -p `dirname $target`
	bcftools concat $(echo $prereq) \
		| bgzip -c > $target.build \
	&& mv $target.build $target	

