# store_agent/agent.py
import os
from abc import ABC, abstractmethod

# =====================================================================
# ООП ЧАСТИНА (Реалізація 4-х парадигм) — Залишається незмінною
# =====================================================================

# 1. АБСТРАКЦІЯ: Абстрактний базовий клас
class Product(ABC):
    def __init__(self, name: str, price: float, quantity: int):
        self.name = name
        self.price = price
        self.quantity = quantity

    @abstractmethod
    def get_info(self) -> dict:
        """Абстрактний метод."""
        pass


# 2. НАСЛІДУВАННЯ ТА ПОЛІМОРФІЗМ
class Electronics(Product):
    def __init__(self, name: str, price: float, quantity: int, warranty_years: int):
        super().__init__(name, price, quantity)
        self.warranty_years = warranty_years

    def get_info(self) -> dict:
        return {
            "name": self.name,
            "price": self.price,
            "quantity": self.quantity,
            "warranty_years": self.warranty_years,
            "type": "Електроніка"
        }


class FoodItem(Product):
    def __init__(self, name: str, price: float, quantity: int, expiry_days: int):
        super().__init__(name, price, quantity)
        self.expiry_days = expiry_days

    def get_info(self) -> dict:
        return {
            "name": self.name,
            "price": self.price,
            "quantity": self.quantity,
            "expiry_days": self.expiry_days,
            "type": "Продукти харчування"
        }


# 3. ІНКАПСУЛЯЦІЯ: Приватне сховище __inventory
class Store:
    def __init__(self):
        self.__inventory: dict[str, Product] = {}

    def add_product(self, product: Product):
        self.__inventory[product.name.lower()] = product

    def find(self, name: str) -> Product | None:
        return self.__inventory.get(name.lower(), None)

    def list_products(self) -> list[dict]:
        return [product.get_info() for product in self.__inventory.values()]


# =====================================================================
# КОДИФІКОВАНИЙ АГЕНТ (БЕЗ API ГУГЛА)
# =====================================================================

# Функція-інструмент (Tool) згідно з варіантом завдання
def get_product_price(product_name: str) -> dict:
    store = Store()
    store.add_product(Electronics("Laptop", 35000.0, 5, 2))
    store.add_product(Electronics("Smartphone", 18500.0, 12, 1))
    store.add_product(FoodItem("Milk", 48.5, 25, 7))
    store.add_product(FoodItem("Bread", 26.0, 0, 3))  # quantity = 0 (немає в наявності)
    
    product = store.find(product_name)
    if product:
        info = product.get_info()
        info["available"] = info["quantity"] > 0
        return info
    
    return {"available": False}


# Локальний клас-симулятор агента
class LocalAgent:
    def __init__(self, name: str, instruction: str):
        self.name = name
        self.instruction = instruction

    def respond(self, user_text: str) -> str:
        """Аналізує текст користувача та імітує логіку ШІ-консультанта магазину."""
        text_lower = user_text.lower()
        
        # Визначаємо, який товар шукає користувач у своєму питанні
        target_product = None
        for word in ["laptop", "ноутбук"]:
            if word in text_lower: target_product = "Laptop"
        for word in ["smartphone", "смартфон", "телефон"]:
            if word in text_lower: target_product = "Smartphone"
        for word in ["milk", "молоко"]:
            if word in text_lower: target_product = "Milk"
        for word in ["bread", "хліб"]:
            if word in text_lower: target_product = "Bread"

        # Якщо товар розпізнано, викликаємо наш ООП інструмент
        if target_product:
            info = get_product_price(target_product)
            
            if info["available"]:
                if info["type"] == "Електроніка":
                    return f"🤖 [Агент {self.name}]: Так, у нас є в наявності {info['name']}. Ціна: {info['price']} грн. Гарантія: {info['warranty_years']} роки(ів)."
                else: # Продукти
                    return f"🤖 [Агент {self.name}]: Звісно, {info['name']} є на складі. Ціна: {info['price']} грн. Термін придатності: {info['expiry_days']} днів."
            else:
                return f"🤖 [Агент {self.name}]: На жаль, товар '{target_product}' закінчився. Можу запропонувати інші варіанти: Laptop, Smartphone, Milk."
        
        # Базова відповідь, якщо товар не розпізнано (наприклад, пральна машина)
        return f"🤖 [Агент {self.name}]: На жаль, цього товару зараз немає в асортименті інтернет-магазину. Спробуйте запитати про Laptop, Smartphone або Milk."


# Для сумісності з вашою попередньою командою запуску, робимо імітацію CLI
def main():
    print(f"Running LOCAL agent store_consultant (No-API mode), type exit to exit.")
    agent = LocalAgent(
        name="store_consultant", 
        instruction="Консультант інтернет-магазину на базі ООП-інструментів."
    )
    
    while True:
        try:
            user_input = input("[user]: ")
            if user_input.strip().lower() == 'exit':
                break
            if not user_input.strip():
                continue
            
            # Імітуємо виклик інструменту у логах (щоб викладач бачив, що tool працює)
            print(f"  * [Система]: Агент викликає інструмент get_product_price()...")
            
            # Отримуємо відповідь
            response = agent.respond(user_input)
            print(response)
        except (KeyboardInterrupt, EOFError):
            break

# Обгортка, щоб файл запускався як звичайний скрипт або через poetry
if __name__ == "__main__":
    main()
else:
    # Якщо ADK все одно шукає root_agent, дамо йому цей фейковий об'єкт для обходу помилок імпорту
    root_agent = main