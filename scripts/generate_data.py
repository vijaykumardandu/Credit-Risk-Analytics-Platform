import random
from pathlib import Path

import pandas as pd
from faker import Faker

fake = Faker("en_IN")

random.seed(42)

BASE_DIR = Path(__file__).resolve().parent.parent

RAW_DATA_DIR = BASE_DIR / "data" / "raw"

RAW_DATA_DIR.mkdir(parents=True, exist_ok=True)

STATES = [
    "Telangana",
    "Karnataka",
    "Tamil Nadu",
    "Maharashtra",
    "Delhi"
]

CITIES = {
    "Telangana": ["Hyderabad", "Warangal", "Karimnagar"],
    "Karnataka": ["Bengaluru", "Mysuru", "Mangalore"],
    "Tamil Nadu": ["Chennai", "Coimbatore", "Madurai"],
    "Maharashtra": ["Mumbai", "Pune", "Nagpur"],
    "Delhi": ["New Delhi"]
}

NUM_CUSTOMERS = 10000
NUM_LOANS = 25000
MAX_PAYMENTS_PER_LOAN = 24

EMPLOYMENT_STATUS = [
    "Salaried",
    "Self-Employed",
    "Business",
    "Government",
    "Student"
]

LOAN_TYPES = [
    "Personal Loan",
    "Home Loan",
    "Car Loan",
    "Education Loan",
    "Business Loan"
]

LOAN_PURPOSES = [
    "Medical",
    "Education",
    "Home Purchase",
    "Vehicle",
    "Business Expansion",
    "Travel",
    "Wedding"
]

APPROVAL_STATUS = [
    "Approved",
    "Rejected",
    "Pending"
]

LOAN_STATUS = [
    "Active",
    "Closed",
    "Default"
]

GENDERS = [
    "Male",
    "Female"
]


def generate_branches():

    branches = []

    branch_id = 1

    for state, cities in CITIES.items():

        for city in cities:

            branch = {
                "branch_id": branch_id,
                "branch_name": f"{city} Branch",
                "city": city,
                "state": state
            }

            branches.append(branch)

            branch_id += 1

    branch_df = pd.DataFrame(branches)

    branch_df.to_csv(
        RAW_DATA_DIR / "branches.csv",
        index=False
    )

    print("branches.csv generated successfully.")
def generate_customers():
    customers = []
    branch_df = pd.read_csv(
    RAW_DATA_DIR / "branches.csv"
    )

    branch_ids = branch_df["branch_id"].tolist()

    for customer_id in range(1, NUM_CUSTOMERS + 1):
        branch_id = random.choice(branch_ids)
        first_name = fake.first_name()

        last_name = fake.last_name()

        gender = random.choice(GENDERS)

        dob = fake.date_of_birth(
            minimum_age=21,
            maximum_age=60
        )
        state = random.choice(STATES)

        city = random.choice(CITIES[state])
        employment = random.choice(EMPLOYMENT_STATUS)
        income = random.randint(
            250000,
            2500000
        )

        debt = random.randint(0,int(income * 0.6))
        credit_score = random.randint(300,850)

        created_at = fake.date_between(
            start_date="-5y",
            end_date="today"
        )

        customers.append({
        "customer_id": customer_id,
        "branch_id": branch_id,
        "first_name": first_name,
        "last_name": last_name,
        "gender": gender,
        "date_of_birth": dob,
        "phone": phone,
        "email": email,
        "city": city,
        "state": state,
        "employment_status": employment,
        "annual_income": income,
        "existing_debt": debt,
        "credit_score": credit_score,
        "created_at": created_at
    })
    customer_df = pd.DataFrame(customers)

    customer_df.to_csv(
        RAW_DATA_DIR / "customers.csv",
        index=False
    )

    print("customers.csv generated successfully.")

def generate_loans():
    customer_df = pd.read_csv(
    RAW_DATA_DIR / "customers.csv"
)
    loans = []
    loan_id = 1
    for _, customer in customer_df.iterrows():
        number_of_loans = random.randint(1, 3)
        for _ in range(number_of_loans):
            customer_id = customer["customer_id"]

            income = customer["annual_income"]

            credit_score = customer["credit_score"]

            if credit_score >= 750:
                max_loan = income * 5

            elif credit_score >= 650:
                max_loan = income * 4

            elif credit_score >= 550:
                max_loan = income * 3

            else:
                max_loan = income * 2

            max_loan = min(
                int(max_loan),
                5000000
            )

            loan_amount = random.randint(
                50000,
                max_loan
            )
            if credit_score >= 750:

                interest_rate = round(
                    random.uniform(7.0, 9.0),
                    2
                )

            elif credit_score >= 650:

                interest_rate = round(
                    random.uniform(9.0, 12.0),
                    2
                )

            else:

                interest_rate = round(
                    random.uniform(12.0, 18.0),
                    2
                )
            loan_term = random.choice(
            [12, 24, 36, 48, 60, 84, 120]
            )
            loan_type = random.choice(
            LOAN_TYPES
            )
            loan_purpose = random.choice(
                LOAN_PURPOSES
            )

            application_date = fake.date_between(
                start_date="-4y",
                end_date="today"
            )
            if credit_score >= 700:

                approval_status = "Approved"

            elif credit_score >= 600:

                approval_status = random.choice(
                    ["Approved", "Pending"]
                )

            else:

                approval_status = random.choice(
                    ["Rejected", "Pending"]
                )

            if approval_status == "Approved":

                loan_status = random.choices(
                    ["Active", "Closed", "Default"],
                    weights=[60, 30, 10],
                    k=1
                )[0]

            else:

                loan_status = "Not Issued"

            loans.append({

                        "loan_id": loan_id,

                        "customer_id": customer_id,

                        "loan_amount": loan_amount,

                        "interest_rate": interest_rate,

                        "loan_term_months": loan_term,

                        "loan_type": loan_type,

                        "loan_purpose": loan_purpose,

                        "application_date": application_date,

                        "approval_status": approval_status,

                        "loan_status": loan_status

                    })


            loan_id += 1
    loan_df = pd.DataFrame(loans)

    loan_df.to_csv(
            RAW_DATA_DIR / "loans.csv",
            index=False
    )

    print("loans.csv generated successfully.")

def generate_repayments():

    loan_df = pd.read_csv(
        RAW_DATA_DIR / "loans.csv"
    )

    repayments = []

    payment_id = 1

    for _, loan in loan_df.iterrows():

        loan_id = loan["loan_id"]
        loan_amount = loan["loan_amount"]
        loan_term = loan["loan_term_months"]
        loan_status = loan["loan_status"]

        application_date = pd.to_datetime(
            loan["application_date"]
        )

        # Skip loans that were never issued
        if loan_status == "Not Issued":
            continue

        emi = round(
            loan_amount / loan_term,
            2
        )

        if loan_status == "Closed":

            number_of_payments = min(
                loan_term,
                MAX_PAYMENTS_PER_LOAN
            )

        elif loan_status == "Active":

            number_of_payments = random.randint(
                1,
                min(loan_term, MAX_PAYMENTS_PER_LOAN)
            )

        else:

            number_of_payments = random.randint(
                1,
                min(6, loan_term)
            )

        remaining_balance = loan_amount

        for payment_number in range(number_of_payments):

            payment_date = (
                application_date +
                pd.DateOffset(
                    months=payment_number + 1
                )
            )

            if loan_status == "Default":

                payment_status = random.choice(
                    ["Paid", "Missed"]
                )

            else:

                payment_status = "Paid"

            if payment_status == "Paid":

                remaining_balance = max(
                    0,
                    round(
                        remaining_balance - emi,
                        2
                    )
                )

            repayments.append({

                "payment_id": payment_id,

                "loan_id": loan_id,

                "payment_date": payment_date.date(),

                "amount_paid": emi,

                "remaining_balance": remaining_balance,

                "payment_status": payment_status

            })

            payment_id += 1

    repayment_df = pd.DataFrame(repayments)

    repayment_df.to_csv(
        RAW_DATA_DIR / "repayments.csv",
        index=False
    )

    print("repayments.csv generated successfully.")



phone = fake.phone_number()

email = fake.unique.email()


if __name__ == "__main__":
    generate_branches()
    generate_customers()
    generate_loans()
    generate_repayments()