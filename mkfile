<mk_concatVCF.mk

CONCATVCF_PREREQ = `{./targets}

results/concatVCF/$CONCATVCF_NAME.vcf.gz:D:	$CONCATVCF_PREREQ
	mkdir -p `dirname $target`
	bcftools concat $(echo $prereq | sed -e 's#\.tbi##g') \
		| bgzip -c > $target.build \
	&& mv $target.build $target	

data/%.vcf.gz:	data/%.vcf
	bgzip $prereq

results/sortindex/%.sorted.vcf.gz:	data/%.vcf.gz
	mkdir -p `dirname $target`
	zcat $prereq \
		| vcf-sort \
		| bgzip -c \
		> $target.build \
	&& mv $target.build $target

results/sortindex/%.sorted.vcf.gz.tbi:	results/sortindex/%sorted.vcf.gz
	mkdir -p `dirname $target`
	tabix -p vcf $prereq