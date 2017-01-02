<mk_concatVCF.mk

CONCATVCF_PREREQ = `{./targets}

results/concatVCF/$CONCATVCF_NAME.vcf.gz:D:		$CONCATVCF_PREREQ
	mkdir -p `dirname $target`
	bcftools $(echo $prereq | sed -e 's#\.tbi##g') \
	| bgzip -c > $target

data/%.vcf.gz:	data/%.vcf
	bgzip $prereq

data/%.sorted.vcf.gz:	data/%.vcf.gz
	vcf-sort $prereq $target

data/%.sorted.vcf.gz.tbi:	data/%sorted.vcf.gz
	tabix -p vcf $prereq