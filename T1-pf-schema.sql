--*****PLEASE ENTER YOUR DETAILS BELOW*****
--T1-pf-schema.sql

--Student ID:33917450
--Student Name:Xianhao Ding


/* Comments for your marker:




*/

-- Task 1 Add Create table statements for the Missing TABLES below.
-- Ensure all column comments, and constraints (other than FK's)are included.
-- FK constraints are to be added at the end of this script

-- VISIT
CREATE TABLE visit (
    visit_id NUMBER(5) NOT NULL,
    visit_date_time DATE NOT NULL,
    visit_length NUMBER(2) NOT NULL,
    visit_notes VARCHAR(200),
    visit_weight NUMBER(4, 1),
    visit_total_cost NUMBER(6, 2),
    animal_id NUMBER(5) NOT NULL,
    vet_id NUMBER(4) NOT NULL,
    clinic_id NUMBER(2) NOT NULL,
    from_visit_id NUMBER(5)
);

ALTER TABLE visit ADD CONSTRAINT visit_pk PRIMARY KEY ( visit_id );

COMMENT ON COLUMN visit.visit_id IS
    'Identifier for visit';
COMMENT ON COLUMN visit.visit_date_time IS
    'Date and time of visit';
COMMENT ON COLUMN visit.visit_length IS
    'Visit length in minutes';
COMMENT ON COLUMN visit.visit_notes IS
    'Vet notes from visit';
COMMENT ON COLUMN visit.visit_weight IS
    'Weight in Kgs';
COMMENT ON COLUMN visit.visit_total_cost IS
    'Total cost for this visit';
COMMENT ON COLUMN visit.animal_id IS
    'Animal identifier';
COMMENT ON COLUMN visit.vet_id IS
    'Identifier for the vet';
COMMENT ON COLUMN visit.clinic_id IS
    'Identifier for the clinic';
COMMENT ON COLUMN visit.from_visit_id IS
    'The previous visits identifier';

-- VISIT_DRUG
CREATE TABLE visit_drug (
    visit_id NUMBER(5) NOT NULL,
    drug_id NUMBER(4) NOT NULL,
    visit_drug_dose VARCHAR(20) NOT NULL,
    visit_drug_frequency VARCHAR(20),
    visit_drug_qtysupplied NUMBER(2) NOT NULL,
    visit_drug_linecost NUMBER(5, 2) NOT NULL
);

ALTER TABLE visit_drug ADD CONSTRAINT visit_drug_pk PRIMARY KEY (visit_id, drug_id);

COMMENT ON COLUMN visit_drug.visit_id IS
    'Identifier for visit';
COMMENT ON COLUMN visit_drug.drug_id IS
    'Drug identifier';
COMMENT ON COLUMN visit_drug.visit_drug_dose IS
    'Dose prescribed in this visit';
COMMENT ON COLUMN visit_drug.visit_drug_frequency IS
    'Frequency prescribed for this drug for this visit';
COMMENT ON COLUMN visit_drug.visit_drug_qtysupplied IS
    'Quantity of drug supplied';
COMMENT ON COLUMN visit_drug.visit_drug_linecost IS
    'Cost charged for drug in this visit';

-- VISIT_SERVICE
CREATE TABLE visit_service (
    visit_id NUMBER(5) NOT NULL,
    service_code CHAR(5) NOT NULL,
    visit_service_linecost NUMBER(6, 2)
);

ALTER TABLE visit_service ADD CONSTRAINT visit_service_pk PRIMARY KEY (visit_id, service_code);

COMMENT ON COLUMN visit_service.visit_id IS
    'Identifier for visit';
COMMENT ON COLUMN visit_service.service_code IS
    'Service identifier';
COMMENT ON COLUMN visit_service.visit_service_linecost IS
    'Cost charged for this service in thisvisit';

-- Add all missing FK Constraints below here
ALTER TABLE visit_drug
    ADD CONSTRAINT vis_visit_drug_fk FOREIGN KEY ( visit_id )
        REFERENCES visit ( visit_id );
        
ALTER TABLE visit_drug
    ADD CONSTRAINT drug_visit_drug_fk FOREIGN KEY ( drug_id )
        REFERENCES drug ( drug_id );

ALTER TABLE visit_service
    ADD CONSTRAINT vis_visit_service_fk FOREIGN KEY ( visit_id )
        REFERENCES visit ( visit_id );

ALTER TABLE visit_service
    ADD CONSTRAINT ser_visit_service_fk FOREIGN KEY ( service_code )
        REFERENCES service ( service_code );

ALTER TABLE visit
    ADD CONSTRAINT visit_vet_fk FOREIGN KEY ( vet_id )
        REFERENCES vet ( vet_id );

ALTER TABLE visit
    ADD CONSTRAINT visit_clinic_fk FOREIGN KEY ( clinic_id )
        REFERENCES clinic ( clinic_id );

ALTER TABLE visit
    ADD CONSTRAINT visit_animal_fk FOREIGN KEY ( animal_id )
        REFERENCES animal ( animal_id );

ALTER TABLE visit
    ADD CONSTRAINT visit_followup_fk FOREIGN KEY ( from_visit_id )
        REFERENCES visit ( visit_id );
