CREATE TABLE patients (
  id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  name VARCHAR(150) NOT NULL,
  date_of_birth DATE NOT NULL
);

CREATE TABLE treatments (
  id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  type VARCHAR(150) NOT NULL,
  name VARCHAR(150)
);

CREATE TABLE medical_histories (
  id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  admitted_at DATE NOT NULL,
  patient_id INT REFERENCES patients(id),
  status VARCHAR(150)
);

CREATE TABLE invoices (
  id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  total_amount DECIMAL NOT NULL,
  generated_at DATE NOT NULL,
  payed_at DATE,
  medical_history_id INT REFERENCES medical_histories(id)
);

CREATE TABLE invoice_items (
  id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  unit_price DECIMAL NOT NULL,
  quantity INT NOT NULL,
  total_price DECIMAL NOT NULL,
  invoice_id INT REFERENCES invoices(id),
  treatment_id INT REFERENCES treatments(id)
);

CREATE TABLE medical_histories_treatments (
  medical_history_id INT,
  treatment_id INT,
  PRIMARY KEY (medical_history_id, treatment_id),
  FOREIGN KEY (medical_history_id) REFERENCES medical_histories(id),
  FOREIGN KEY (treatment_id) REFERENCES treatments(id)
);

CREATE INDEX fk_medical_histories_patient_id ON medical_histories(patient_id);
CREATE INDEX fk_invoices_medical_history_id ON invoices(medical_history_id);
CREATE INDEX fk_invoice_items_invoice_id ON invoice_items(invoice_id);
CREATE INDEX fk_invoice_items_treatment_id ON invoice_items(treatment_id);
CREATE INDEX fk_medical_histories_treatments_medical_history_id ON medical_histories_treatments(medical_history_id);
CREATE INDEX fk_medical_histories_treatments_treatment_id ON medical_histories_treatments(treatment_id);
