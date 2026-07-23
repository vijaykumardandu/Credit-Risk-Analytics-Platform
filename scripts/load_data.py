import pandas as pd
import mysql.connector
from pathlib import Path

# =====================================================
# Project Paths
# =====================================================

PROJECT_ROOT = Path(__file__).resolve().parent.parent

RAW_DATA_DIR = PROJECT_ROOT / "data" / "raw"

# =====================================================
# Database Configuration
# =====================================================

DB_CONFIG = {
    "host": "localhost",
    "user": "root",
    "password": "798100",      
    "database": "credit_risk_db"
}

# =====================================================
# Connect to MySQL
# =====================================================

def get_connection():

    connection = mysql.connector.connect(
        host=DB_CONFIG["host"],
        user=DB_CONFIG["user"],
        password=DB_CONFIG["password"],
        database=DB_CONFIG["database"]
    )

    return connection


# =====================================================
# Clear Existing Data
# =====================================================

def clear_tables(connection):

    cursor = connection.cursor()

    print("\nClearing existing data...")

    cursor.execute("SET FOREIGN_KEY_CHECKS = 0")

    tables = [
        "repayments",
        "loans",
        "customers",
        "branches"
    ]

    for table in tables:

        cursor.execute(f"DELETE FROM {table}")

        print(f"✓ Cleared {table}")

    cursor.execute("SET FOREIGN_KEY_CHECKS = 1")

    connection.commit()

    cursor.close()

    print("Database cleaned successfully.\n")


# =====================================================
# Load CSV into Table
# =====================================================

def load_csv_to_table(connection, csv_file, table_name):

    print(f"Loading {table_name}...")

    df = pd.read_csv(csv_file)

    print(f"Rows Found : {len(df)}")

    cursor = connection.cursor()

    columns = list(df.columns)

    column_names = ", ".join(columns)

    placeholders = ", ".join(["%s"] * len(columns))

    insert_query = f"""
        INSERT INTO {table_name}
        ({column_names})
        VALUES ({placeholders})
    """

    for _, row in df.iterrows():

        cursor.execute(
            insert_query,
            tuple(row)
        )

    connection.commit()

    cursor.close()

    print(f"✓ {table_name} loaded successfully.\n")


# =====================================================
# Main
# =====================================================

if __name__ == "__main__":

    try:

        connection = get_connection()

        if connection.is_connected():

            print("=" * 55)
            print(" CREDIT RISK ANALYTICS ETL PIPELINE ")
            print("=" * 55)

            print("\nSuccessfully connected to MySQL.")

            clear_tables(connection)

            load_csv_to_table(
                connection,
                RAW_DATA_DIR / "branches.csv",
                "branches"
            )

            load_csv_to_table(
                connection,
                RAW_DATA_DIR / "customers.csv",
                "customers"
            )

            load_csv_to_table(
                connection,
                RAW_DATA_DIR / "loans.csv",
                "loans"
            )

            load_csv_to_table(
                connection,
                RAW_DATA_DIR / "repayments.csv",
                "repayments"
            )

            print("=" * 55)
            print("ETL PIPELINE COMPLETED SUCCESSFULLY")
            print("=" * 55)

    except mysql.connector.Error as err:

        print("\nDatabase Error:")
        print(err)

    except Exception as e:

        print("\nUnexpected Error:")
        print(e)

    finally:

        if "connection" in locals() and connection.is_connected():

            connection.close()

            print("\nMySQL connection closed.")