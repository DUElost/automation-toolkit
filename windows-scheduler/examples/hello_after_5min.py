from datetime import datetime


def main() -> None:
    current_time = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    print(f"Hello from scheduled Python task at {current_time}")


if __name__ == "__main__":
    main()
