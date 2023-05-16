import 'dart:convert';
import 'dart:io';

import 'package:postgres/postgres.dart';

void main(List<String> arguments) async {
  final conn = PostgreSQLConnection(
    'localhost',
    5432,
    'dart_test',
    username: 'postgres',
    password: 'admin',
  );

  // ===========================================================================
  // [Connect to database]
  await conn.open();
  print('Connected to Postges database...');

  // ===========================================================================
  // [Creating Table Customers]
  // NOTE: Do this as part of DB setup not in application code!
  await conn.query('''
    CREATE TABLE IF NOT EXISTS public.customers(
      id serial primary key not null,
      name text,
      email text,
      address text,
      country text
    )
  ''');

  // ===========================================================================
  // [Create Data]
  // await conn.query('''
  //   INSERT INTO customers (name,email,address,country)
  //   VALUES ('Qisah Tegar','kisah@mail.co','3414 Beral Street','Indonesia')
  // ''');

  // ===========================================================================
  // [Read Data]
  // var results = await conn.query('SELECT * FROM customers');

  // for (var row in results) {
  //   print('''
  //   ===
  //   id: ${row[0]}
  //   name: ${row[1]}
  //   email: ${row[2]}
  //   address: ${row[3]}
  //   country: ${row[4]}
  //   ===
  //   ''');
  // }

  // print(results);

  // ===========================================================================
  // [Update Data]
  // await conn.query("UPDATE customers SET country='Ghana' WHERE id=1");

  // ===========================================================================
  // [Delete Data]
  // await conn.query('DELETE FROM customers WHERE id > 0');

  // ===========================================================================
  // [Populate Customers Table]
  await conn.transaction((ctx) async {
    final mockStr = await File('./json/mock_customers.json').readAsString();
    final mockData = json.decode(mockStr);
    final mockDataStream = Stream.fromIterable(mockData);

    await for (var row in mockDataStream) {
      await ctx.query(
        '''
          INSERT INTO customers (name, email, address, country)
          VALUES (@name, @email, @address, @country)
        ''',
        substitutionValues: {
          'name': row['name'],
          'email': row['email'],
          'address': row['address'],
          'country': row['country'],
        },
      );
    }
  });

  // ===========================================================================
  // [Creating Table Orders]
  // NOTE: Do this as part of DB setup not in application code!
  await conn.query('''
    CREATE TABLE IF NOT EXISTS public.orders(
      id serial primary key not null,
      order_id int not null,
      customer_id int not null,
      order_date date
    )
  ''');

  // ===========================================================================
  // [Populate Orders Table]
  await conn.transaction((ctx) async {
    final mockStr = await File('./json/mock_orders.json').readAsString();
    final mockData = json.decode(mockStr);
    final mockDataStream = Stream.fromIterable(mockData);

    await for (var row in mockDataStream) {
      await ctx.query(
        '''
          INSERT INTO orders (order_id,customer_id,order_date)
          VALUES (@orderId,@customerId,@orderDate)
        ''',
        substitutionValues: {
          'orderId': row['order_id'],
          'customerId': row['customer_id'],
          'orderDate': row['order_date'],
        },
      );
    }
  });

  // ===========================================================================
  // [Mapped results of customers that have an order]
  var resultsMap = await conn.mappedResultsQuery('''
    SELECT customers.name, orders.order_id
    FROM customers
    LEFT JOIN orders ON customer_id = orders.customer_id
    WHERE orders.order_id > 0
    ORDER BY customers.name
  ''');

  for (var row in resultsMap) {
    print('''
    ===
    Customer name: ${row['customers']!['name']}
    Order Id: ${row['orders']!['order_id']}
    ===
    ''');
  }

  // print(resultsMap);

  // ===========================================================================
  // [Disconnect to database]
  await conn.close();
}
