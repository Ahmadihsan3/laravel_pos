<?php

namespace App\Exports;

use App\Models\OrderItem;
use Illuminate\Support\Collection;
use Maatwebsite\Excel\Concerns\FromCollection;
use Maatwebsite\Excel\Concerns\WithHeadings;
use Maatwebsite\Excel\Concerns\WithEvents;
use Maatwebsite\Excel\Events\AfterSheet;

class OrderItemsExport implements FromCollection, WithHeadings, WithEvents
{
    protected $orderItems;

    public function __construct(Collection $orderItems)
    {
        $this->orderItems = $orderItems;
    }

    public function collection()
    {
        return $this->orderItems->map(function ($item, $index) {
            $transactionDate = $item->order->created_at->format('d-m-Y H:i:s');
            return [
                'No' => $index + 1, // Nomor urut dimulai dari 1
                'Product Name' => $item->product->name,
                'Price' => $item->product->price,
                'Quantity' => $item->quantity,
                'Total Product Price' => $item->quantity * $item->product->price,
                'Transaction Date' => $transactionDate,
            ];
        });
    }

    public function headings(): array
    {
        return [
            'No',
            'Product Name',
            'Price',
            'Quantity',
            'Total Product Price',
            'Transaction Date',
        ];
    }

    // Method to calculate total quantity
    public function getTotalQuantity()
    {
        return $this->orderItems->sum('quantity');
    }

    // Method to calculate total price
    public function getTotalPrice()
    {
        return $this->orderItems->sum(function ($item) {
            return $item->quantity * $item->product->price;
        });
    }

    public function registerEvents(): array
    {
        return [
            AfterSheet::class => function (AfterSheet $event) {
                $totalQuantity = $this->getTotalQuantity();
                $totalPrice = $this->getTotalPrice();

                $lastRow = $this->orderItems->count() + 2; // Baris terakhir setelah data order items

                $event->sheet->setCellValue("D$lastRow", $totalQuantity);
                $event->sheet->setCellValue("E$lastRow", $totalPrice);

                $event->sheet->getStyle("D$lastRow:E$lastRow")->applyFromArray([
                    'font' => ['bold' => true],
                ]);
            },
        ];
    }
}
