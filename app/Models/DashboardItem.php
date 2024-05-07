<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class DashboardItem extends Model
{
    use HasFactory;

    protected $fillable =
    [
        'dashboard_id',
        'product_id',
        'quantity',
        'total_price'
    ];

    public function Dashboard()
    {
        return $this->belongsTo(Dashboard::class, 'dashboard_id', 'id');
    }

    public function product()
    {
        return $this->belongsTo(Product::class, 'product_id', 'id');
    }
}
