-- Checks documentados. El backend ya valida estos valores.
-- No ejecutes ALTER si la tabla de producción ya tiene filas raras.

-- scans.material_code in ('PET','HDPE','MLT','PAP','VID','MET','ORG','GEN')
-- scans.confidence between 0 and 1
-- lab_attempts.bin_id in ('yellow','blue','green','black','brown')
-- lab_attempts.delta in (0, -5)
